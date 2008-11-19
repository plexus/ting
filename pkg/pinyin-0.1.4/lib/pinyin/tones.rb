module Pinyin
  #
  # Base class for Tone classes
  #
  class Tone
    VALID_TONES  = 1..5
    MAX_TONE = NEUTRAL_TONE = 5

    class <<self
    def add_tone(s,t)
      s
    end

    def peek_tone(s)
      NEUTRAL_TONE
    end

    def pop_tone(s)
      [NEUTRAL_TONE, s]
    end

    private
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

require "pinyin/tones/marks"
require "pinyin/tones/numbers"
require "pinyin/tones/accents"
require "pinyin/tones/no_tones"

module Pinyin
  module Tones
    All = [Numbers, Marks, Accents, NoTones]
    MAX_TONE = NEUTRAL_TONE = 5
    VALID_TONES  = 1..5
  end
end
