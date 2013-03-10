# coding: utf-8

module Ting

  #
  # Base class for conversions like Hanyu pinyin,
  # Wade-Giles, etc.
  #
  class Conversion

    # Separator between syllables in the same word
    # For Wade-Giles this is a dash, Hanyu pinyin
    # uses a single quote in certain situations
    attr_reader :syllable_separator

    # The tone handling object
    attr_reader :tones

    # An optional lambda that preprocesses input
    attr_reader :preprocessor

    # The name of this conversion, the same name used
    # in the data file and that is also available as
    # a method name on Initial and Final objects.
    #
    # By default the underscorized class name
    attr_reader :name

    def initialize(tone = :numbers, options = {})
      @preprocessor = options[:preprocessor] || lambda {|s| s}

      if Tone === tone
        @tone = tone
      else
        @tone = Ting::Tones.const_get(tone.to_s.camelcase)
      end

      @name = self.class.name.underscore
    end

    # Converts a string into an array of strings and
    # syllable objects.
    def parse(string)
    end

    # Converts an array of strings and syllable objects
    # into a string
    def unparse(array)
    end

  end
end
