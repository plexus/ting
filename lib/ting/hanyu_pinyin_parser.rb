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

    def consonant_syllables
      @consonant_syllables ||= all_syllables.grep(/^[bcdfghjklmnpqrstwxyz]/i)
    end

    def pinyin_regexp
      # This will parse a cluster of pinyin, i.e. an uninterrupted string of pinyin characters without punctuation.
      # In the middle of a cluster, we know that syllables starting in a vowel (like 'an') cannot appear,
      # because these syllables have to be prefixed with an apostrophe.
      # Example: "hǎi'àn" must be parsed as two clusters ("hǎi" and "àn"), whereas "gūnánguǎnǚ" is a single cluster.
      @pinyin_cluster_regexp ||= /\A(#{Regexp.union(all_syllables)})(#{Regexp.union(consonant_syllables)})*(r)?\Z/
    end

    def pinyin_separator_regexp
      # A regular expression that matches every character that can *not* appear in pinyin.
      @pinyin_separator_regexp ||= Regexp.new("[^#{all_syllables.join.downcase.split("").sort.uniq.join}]+")
    end

    def parse_cluster(pinyin)
      syllables = []

      # Chop off one syllable at a time from the end by continuously matching the same regular expression.
      # This ensures the pinyin will be split into only valid pinyin syllables. Because a match capture will
      # only contain the *last* content it has matched, we have to use a loop.
      while match = pinyin_regexp.match(pinyin)
        # If an 'r' at the end was matched, this implies that all other parts of the string were matched as
        # syllables, and this cluster uses erhua.
        if 'r' == match[3]
          syllables << 'er'
          pinyin = pinyin.chop
        end
        last_syllable = match[2] || match[1]
        syllables << last_syllable
        pinyin = pinyin[0, pinyin.length - last_syllable.length]
      end

      raise ArgumentError, "Unparseable pinyin fragment encountered: #{pinyin}" if !pinyin.empty?

      syllables.reverse
    end

    def parse(pinyin)
      # hanyu_reader cannot parse uppercase pinyin.
      pinyin = pinyin.downcase

      clusters = pinyin.split(pinyin_separator_regexp)
      clusters.flat_map {|cluster| parse_cluster(cluster)}.flat_map(&hanyu_reader)
    end
    alias call parse

  end
end
