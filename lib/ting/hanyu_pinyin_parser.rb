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
      @pinyin_cluster_regexp ||= /\A
        # Every syllable can appear at the start of a cluster.
        (#{Regexp.union(all_syllables)})
        # However, only syllables starting with a consonant can follow, as syllables starting with a vowel have to
        # be prefixed with an apostrophe.
        # Since it is common to omit the apostrophe when there is no ambiguity, also allow syllables starting with
        # a vowel after all letters except n and g, and after -ong, since -on does not appear at the end of a valid
        # syllable.
        (#{Regexp.union(consonant_syllables)}|(?<=[^ng]|[ōóǒòo]ng)#{Regexp.union(all_syllables)})*
        (r)?
        \Z/x
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
