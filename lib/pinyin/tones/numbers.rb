module Pinyin
  module Tones
    class Numbers < Tone
      class <<self

      def add_tone(syll, tone)
        syll + normalize(tone).to_s
      end

      def peek_tone(syll)
        if syll =~ /(\d)\Z/
          normalize Integer($1)
        else
          NEUTRAL_TONE
        end
      end      

      def pop_tone(syll)
        [ peek_tone(syll), syll[/\A\D+/] ]
      end

      end
    end
  end
end
