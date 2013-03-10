# -*- coding: utf-8 -*-
require 'test/unit'
require 'ting'
require 'yaml'

module HanyuCoverage

  class Test_ParseUnparse < Test::Unit::TestCase
    include Ting
    def initialize(s)
      super(s)
      @reader = Ting.reader(:hanyu, :no_tones)
      @writer = Ting.writer(:hanyu, :no_tones)
    end

    grid=YAML.load(File.open(File.expand_path('../../lib/ting/data/valid_pinyin.yaml', __FILE__), 'r:UTF-8').read)
    grid.each do |fname, row|
      row.each do |iname, hanyu|
        hanyu=hanyu.force_encoding('UTF-8')
        safe_hanyu = hanyu.gsub('ü','v').gsub('ê','_e')

        define_method :"test_unparse_#{safe_hanyu}" do
          assert_equal(
            hanyu,
            @writer.unparse(
              Syllable.new(Initial.const_get(iname), Final.const_get(fname), Tones::NEUTRAL_TONE)
            ),
            "Wrong hanyu for Initial::#{iname}+Final::#{fname}, expected `#{hanyu}` "
          )
        end

        define_method :"test_parse_#{safe_hanyu}" do
          ts=@reader.parse(hanyu).first
          assert_not_nil(ts, "Reader<:hanyu, :no_tone>#parse('#{hanyu}') returned nil")
          assert_equal(Initial.const_get(iname), ts.initial, "Wrong initial for `#{hanyu}`, expected Initial::#{iname}")
          assert_equal(Final.const_get(fname), ts.final, "Wrong final for `#{hanyu}`, expected Final::#{fname}")
        end

      end
    end
  end
end
