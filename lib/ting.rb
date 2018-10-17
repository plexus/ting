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
require 'ting/hanyu_pinyin_parser'
require 'ting/memoize_call'

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

    # The longest syllables are six letters long (chuang, shuang, zhuang).
    SYLLABLE_REGEXP = /[A-Za-züÜ]{1,6}\d?/

    def pretty_tones(string)
      string = string.gsub('u:', 'ü') # (note that this implicitly dups the string)
      # Scan through the string, replacing syllable by syllable.
      pos = 0
      while match = string.match(SYLLABLE_REGEXP, pos)
        syllable = match[0]
        replacement = SYLLABLE_CACHE[syllable]
        match_pos = match.begin(0)
        # If this syllable starts with a vowel and is preceded by a letter (not whitespace or
        # control characters), insert an apostrophe before it.
        if match_pos > 0 && string[match_pos - 1] =~ /[[:alpha:]]/ && syllable =~ /^[AEOaoe]/
          replacement = "'" + replacement
        end
        string[match_pos, syllable.length] = replacement
        pos = match_pos + replacement.length
      end
      string
    end

    def bpmf(string)
      string.gsub('u:', 'ü').scan(SYLLABLE_REGEXP).map do |m|
        Ting.writer(:zhuyin, :marks).(
          Ting.reader(:hanyu, :numbers).(m.downcase)
        )
      end.join(' ')
    end

  end
end
