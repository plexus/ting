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
      @with_erhua ||= all_syllables.map{|p| p + 'r'}
    end

    def pinyin_regexp
      @pinyin_regexp ||= Regexp.union(*sylls_with_erhua, *all_syllables)
    end

    def split_pinyin(pinyin)
      pinyin.scan(pinyin_regexp).flat_map do |syll|
        if sylls_with_erhua.include?(syll) && ! all_syllables.include?(syll)
          [ syll[0..-2], 'er']
        else
          [ syll ]
        end
      end
    end

    def parse(pinyin)
      split_pinyin(pinyin).map(&hanyu_reader)
    end
    alias call parse

  end
end
