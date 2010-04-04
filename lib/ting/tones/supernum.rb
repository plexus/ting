module Ting
  module Tones
    class Supernum < Tone
      class <<self

        GLYPHS=['', '¹', '²', '³', '⁴',] #⁰ for neutral tone?

        def add_tone(syll,tone)
          syll + GLYPHS[normalize(tone) % 5]
        end

        def peek_tone(syll)
          return t if t = GLYPHS.index(syll.chars[-1])
          return NEUTRAL_TONE
        end

        def pop_tone(syll)
          [ peek_tone(syll), syll[/\A[^#{GLYPHS.join}]+/] ]
        end

      end
    end
  end
end
