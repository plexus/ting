# -*- coding: utf-8 -*-

# Handle several romanization systems for Mandarin Chinese
#
# Author::     Arne Brasseur (arne@arnebrasseur.net)
# Copyright::  Copyright (c) 2007-2014, Arne Brasseur
# Licence::    GNU General Public License, v3

require 'ting/version'
require 'ting/groundwork'
require 'ting/exception'

require 'ting/tones'
require 'ting/conversion'
require 'ting/conversions'
require 'ting/conversions/hanyu'

require 'ting/procable'
require 'ting/reader'
require 'ting/writer'
require 'ting/converter'

module Ting
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

    def camelize(str)
      str = str.dup
      str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
      str.gsub!(/(\A|\s)([a-z])/){ $1 + $2.upcase }
      str
    end

    SYLLABLE_CACHE = Hash.new do |hsh, syll|
      hsh[syll] = Ting.writer(:hanyu, :accents).(
        Ting.reader(:hanyu, :numbers).(syll.downcase)
      )
    end


    def pretty_tones(string)
      string.gsub('u:','ü').gsub(/[A-Za-züÜ]{1,5}\d/) do |syll|
        SYLLABLE_CACHE[syll]
      end
    end

    def bpmf(string)
      string.gsub('u:','ü').scan(/[A-Za-züÜ]{1,5}\d/).map do |m|
        Ting.writer(:zhuyin, :marks).(
          Ting.reader(:hanyu, :numbers).(m.downcase)
        )
      end.join(' ')
    end

  end
end
