# coding: utf-8

module Ting
  module Tones
    class Accents < Tone
      class << self

      UNICODE_TONE_GLYPHS={ 
        :a=>[97, 257, 225, 462, 224],
        :e=>[101, 275, 233, 283, 232],
        :i=>[105, 299, 237, 464, 236],
        :o=>[111, 333, 243, 466, 242],
        :u=>[117, 363, 250, 468, 249],
        :v=>[252, 470, 472, 474, 476]
      }

      def tone_glyph(letter,tone)
        if (u=UNICODE_TONE_GLYPHS[letter.to_sym][tone%MAX_TONE])
          [u].pack('U')
        end
      end

      def add_tone(syll, tone)
        syll.gsub!('ü','v')
        tone %= MAX_TONE
        case syll
        when /a/
          syll.sub(/a/, tone_glyph(:a,tone))
        when /e/
          syll.sub(/e/, tone_glyph(:e,tone))
        when /o/
          syll.sub(/o/, tone_glyph(:o,tone))
        when /(i|u|v)/
          syll.sub($1, tone_glyph($1,tone))
        else
          syll
        end  
      end

      def peek_tone(syll)
        unpacked = syll.unpack('U*')
        each_tone_glyph do |vowel, tones|
          tone_glyph=unpacked.find {|t| tones.include?(t)}
          normalize( tones.index(tone_glyph) ) if tone_glyph
        end
      end

      def pop_tone(syll)
        unpacked = syll.unpack('U*')
        each_tone_glyph do |vowel, tones|
          if tone_glyph = unpacked.find {|t| tones.include?(t)}
            unpacked[unpacked.index(tone_glyph)]=vowel.to_s[0]
            break [normalize(tones.index(tone_glyph)), unpacked.pack('U*')]
          end
        end
      end

      private
        def each_tone_glyph
          [:a,:e,:i,:o,:u,:v].each do |v|  #Order is significant
            vowel, tones = v, UNICODE_TONE_GLYPHS[v]
            yield vowel,tones
          end
        end

      end
    end
  end
end
