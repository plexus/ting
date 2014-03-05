# coding: utf-8

module Ting
  module Conversions
    class Hanyu
      def initialize(tone = :numbers, options = {})
        @options = options
        @options[:preprocess] ||= lambda {|s| s.gsub(/u:|Ü/, 'ü').downcase }

        if Class === tone
          @tone = tone
        else
          @tone = Ting::Tones.const_get(Ting.camelize(tone.to_s))
        end
      end

      def valid_character_regexp
        @valid_character_regexp ||= valid_character_regexp!
      end

      def valid_character_regexp!
        valid_chars = []
        Ting.valid_combinations do |i,f|
          1.upto(5) do |tone|
            valid_chars += @tone.add_tone(Conversions.unparse(:hanyu,Syllable.new(i,f)), tone).chars.to_a
          end
        end
        valid_chars.sort!.uniq!
        Regexp.new(valid_chars.map{|ch| Regexp.escape(ch)}.join('|'))
      end

      def parse(string)
        result = []
        looking_at = []
        string.chars.each do |ch|
          head, syll = parse_tail(looking_at)
          looking_at << ch
          if syll && !parse_tail(looking_at)
            puts "-> #{syll.inspect}"
            result << head.to_s unless head.empty?
            result << syll
            looking_at = [ch]
          end
        end
        result
      end

      def parse_tail(chars)
        7.downto(1) do |i|
          head = chars[0...-i]
          tail = chars[-i..-1]
          syll = parse_syllable( tail )
          return head, syll if syll
        end
        nil
      end

      def parse_syllable(tone_syll)
        tone_syll = tone_syll.to_s
        tone_syll = @options[:preprocess].call(tone_syll) if @options[:preprocess]
        tone, syll = @tone.pop_tone(tone_syll)
        if tone && syll
          ini_fini = Conversions.parse(:hanyu,syll)
          if ini_fini
            p tone, syll, ini_fini
            ini, fini = ini_fini.initial, ini_fini.final
          end

          return Syllable.new(ini, fini, tone) if tone && ini && fini
        end
      end

    end
  end
end
