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
        syll = syll.sub('ü','v')
        tone = tone % MAX_TONE
        case syll
        when /a/
          syll.sub(/a/, tone_glyph(:a,tone))
        when /e/
          syll.sub(/e/, tone_glyph(:e,tone)).sub('v', 'ü')
        when /o/
          syll.sub(/o/, tone_glyph(:o,tone))
        when /(i|u|v)\z/
          syll.sub($1, tone_glyph($1,tone)).sub('v', 'ü')
        when /(i|u|v)/
          syll.sub($1, tone_glyph($1,tone)).sub('v', 'ü')
        else
          syll
        end
      end

      def peek_tone(syll)
        candidates = each_tone_glyph.map do |vowel, tones|
          tone_glyph = syll.codepoints.find {|t| tones.include?(t)}
          normalize( tones.index(tone_glyph) ) if tone_glyph
        end.compact
        candidates.reject {|tone| tone == 5}.first || candidates.first
      end

      # returns [ tone number, syllable without tone ]
      # e.g. ni3 => [ 3, 'ni' ]
      def pop_tone(syll)
        tone = peek_tone(syll)
        unpacked = syll.codepoints.to_a
        each_tone_glyph do |vowel, tone_glyph_codepoints|
          tone_glyph_cp = tone_glyph_codepoints[tone % MAX_TONE]
          if unpacked.include? tone_glyph_cp
            unpacked[unpacked.index(tone_glyph_cp)] = vowel.to_s.unpack('U').first
            return [normalize(tone_glyph_codepoints.index(tone_glyph_cp)), unpacked.pack('U*').sub('v', 'ü')]
          end
        end
      end

      private
        def each_tone_glyph
          return to_enum(__method__) unless block_given?
          [:a,:e,:i,:o,:u,:v].each do |v|  #Order is significant
            vowel, tones = v, UNICODE_TONE_GLYPHS[v]
            yield vowel,tones
          end
        end

      end
    end
  end
end
