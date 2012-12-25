module Ting
  #
  # Base class for Tone classes
  #
  class Tone
    VALID_TONES  = 1..5
    MAX_TONE = NEUTRAL_TONE = 5

    class << self
      # Add a tone to a syllable
      def add_tone(s,t)
        s
      end

      # Determine the tone of a syllable
      def peek_tone(s)
        NEUTRAL_TONE
      end

      # Remove the tone from a syllable
      def pop_tone(s)
        [NEUTRAL_TONE, s]
      end

    private
      # Make sure the tone number is in the valid range.
      # Neutral tone is always represented as NEUTRAL_TONE (5), and not 0.
      def normalize(t)
        if VALID_TONES === t
          t
        else
          t %= MAX_TONE
          t = NEUTRAL_TONE if t == 0
        end
      end

    end
  end
end

# Tone marks as a separate glyph, e.g. for Bopomofo
require "ting/tones/marks"

# Tone numbers added after the syllable
require "ting/tones/numbers"

# Tone accents, for Hanyu pinyin
require "ting/tones/accents"

# Superscript numerals, for Wade-Giles
require "ting/tones/supernum"

# IPA tone symbols
require "ting/tones/ipa"

# No tones
require "ting/tones/no_tones"

module Ting
  module Tones
    All = [Numbers, Marks, Accents, NoTones]
    VALID_TONES  = 1..5
    MAX_TONE = NEUTRAL_TONE = 5
  end
end
