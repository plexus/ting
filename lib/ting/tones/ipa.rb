# coding: utf-8

module Ting
  module Tones
    class Ipa < Tone
      class <<self

        GLYPHS=['', '˥˥', '˧˥', '˧˩˧', '˥˩',] #http://wapedia.mobi/en/Wikipedia:IPA_for_Mandarin

        def add_tone(syll,tone)
          syll + GLYPHS[normalize(tone) % 5]
        end

        def peek_tone(syll)
          if t = GLYPHS.index(syll.chars.last)
            return t
          end
          return NEUTRAL_TONE
        end

        def pop_tone(syll)
          [ peek_tone(syll), syll[/\A[^#{GLYPHS.join}]+/] ]
        end

      end
    end
  end
end
