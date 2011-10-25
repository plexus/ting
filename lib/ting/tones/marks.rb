# coding: utf-8

module Ting
  module Tones
    class Marks < Tone
      class <<self

        GLYPHS=['˙', '', 'ˊ', 'ˇ', 'ˋ']

        def add_tone(syll,tone)
          syll + GLYPHS[normalize(tone) % 5]
        end

        def peek_tone(syll)
          case syll
          when /ˊ/
            2
          when /ˇ/
            3
          when /ˋ/
            4
          when /˙/
            NEUTRAL_TONE
          else 
            1
          end
        end

        def pop_tone(syll)
          [ peek_tone(syll), syll[/\A[^#{GLYPHS.join}]+/] ]
        end

      end
    end
  end
end
