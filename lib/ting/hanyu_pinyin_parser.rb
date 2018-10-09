module Ting
  class HanyuPinyinParser
    include Procable

    def hanyu_writer
      @hanyu_writer ||= Ting.writer(:hanyu, :accents)
    end

    def hanyu_reader
      @hanyu_reader ||= Ting.reader(:hanyu, :accents)
    end

    def all_syllables
      @all_syllables ||= Ting.all_syllables.map(&hanyu_writer).sort_by(&:length).reverse
    end

    def sylls_with_erhua
      @with_erhua ||= all_syllables.
                        # We assume that syllables ending in 'r' cannot have additional erhua.
                        reject {|p| p.end_with?('r')}.
                        # Don't shadow existing syllables, to avoid parsing "er" as "e" + "er".
                        reject {|p| all_syllables.include?(p + 'r')}.
                        # Erhua syllables must be followed by whitespace.
                        map {|p| p + 'r '}
    end

    def pinyin_regexp
      @pinyin_regexp ||= Regexp.union(*sylls_with_erhua, *all_syllables)
    end

    def split_pinyin(pinyin)
      pinyin.scan(pinyin_regexp).flat_map do |syll|
        if sylls_with_erhua.include?(syll) && ! all_syllables.include?(syll)
          # For erhua syllables, cut off the trailing 'r ' string (added in #sylls_with_erhua).
          # Insert a silent er5 syllable in its place.
          [ syll[0..-3], 'er']
        else
          [ syll ]
        end
      end
    end

    def parse(pinyin)
      # Ting cannot parse uppercase pinyin with accents yet.
      pinyin = pinyin.downcase
      # Normalize all whitespace into a single space.
      pinyin = pinyin.gsub(/[[:space:][:punct:]]/, " ")
      # Append a space to the string so that the regexp above will match erhua at the end.
      pinyin += ' '
      split_pinyin(pinyin).map(&hanyu_reader).flatten
    end
    alias call parse

  end
end
