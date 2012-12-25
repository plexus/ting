# Handle several romanization systems for Mandarin Chinese
#
# Author::     Arne Brasseur (arne@arnebrasseur.net)
# Copyright::  Copyright (c) 2007-2010, Arne Brasseur
# Licence::    GNU General Public License, v3

require 'ting/version'
require 'ting/support'
require 'ting/groundwork'
require 'ting/exception'

require 'ting/tones'
require 'ting/conversion'
require 'ting/conversions'
require 'ting/conversions/hanyu'

module Ting
  class Reader
    def initialize(conv, tone)
      @conv = conv.to_s
      @tone = Tones.const_get tone.to_s.camelcase
      @cache = {}
    end

    def parse(str)
      return @cache[str] ||= Conversions.tokenize(str).map do |s, pos|
        tone,syll = @tone.pop_tone(s)
        tsyll = Conversions.parse(@conv,syll)
        ini, fin = tsyll.initial, tsyll.final
        unless tone && fin && ini
          raise ParseError.new(s,pos),"Illegal syllable <#{s}> in input <#{str}> at position #{pos}." 
        end
        Syllable.new(ini, fin, tone)
      end
    rescue Object => e
      raise ParseError.new(str,0), "Parsing of #{str.inspect} failed : #{e}"
    end

    alias :<< :parse
  end

  class Writer
    def initialize(conv, tone)
      @conv = conv.to_s
      @tone = Tones.const_get tone.to_s.camelcase
      @cache = {}
    end

    def generate(py)
      conv=lambda {|syll| @tone.add_tone(Conversions.unparse(@conv,syll),syll.tone)}
      return @cache[py] ||= if py.respond_to? :map
        py.map(&conv).join(' ')
      else
        conv.call(py)
      end
    end

    alias :<< :generate
    alias :unparse :generate
  end

  class Converter
    attr_reader :from_conv, :from_tone, :to_conv, :to_tone
    
    def initialize(from, from_tone, to, to_tone)
      @from_conv, @from_tone, @to_conv, @to_tone = from, from_tone, to, to_tone
    end

    def reader
      @reader ||= Reader.new(from_conv, from_tone)
    end

    def writer
      @writer ||= Writer.new(to_conv, to_tone)
    end

    def convert(str)
      writer.unparse reader.parse(str)
    end

    def to(to, to_tone)
      Converter.new(self.from_conv, self.from_tone, to, to_tone)
    end

    alias :<< :convert
  end
  
  class << self
    def reader(format, tones)
      Reader.new(format,tones)
    end
    def writer(format, tones)
      Writer.new(format,tones)
    end
    def from(from, from_tone)
      Converter.new(from, from_tone, nil, nil)
    end
  end

end
