# Handle several romanization systems for Mandarin Chinese
#
# Author::     Arne Brasseur (arne@arnebrasseur.net)
# Copyright::  Copyright (c) 2007-2010, Arne Brasseur
# Licence::    GNU General Public License, v3

$: << File.dirname(__FILE__)

require 'ting/support'
require 'ting/groundwork'
require 'ting/exception'

require 'ting/tones'
require 'ting/conversion'
require 'ting/conversions'
require 'ting/conversions/hanyu'

module Ting
  VERSION = "0.2.0"

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
    def initialize(from, from_tone, to, to_tone)
      @reader = Reader.new(from, from_tone)
      @writer = Writer.new(to, to_tone)
    end

    def convert(str)
      @writer.unparse @reader.parse(str)
    end

    alias :<< :convert
  end
  
  class <<self
    READERS={}
    WRITERS={}

    def reader(format, tones)
      return READERS[[format, tones]] ||= Reader.new(format,tones)
    end
    def writer(format, tones)
      return WRITERS[[format, tones]] ||= Writer.new(format,tones)
    end
  end

end


Pinyin = Ting #legacy support
