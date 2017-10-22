require 'ting'
require 'test/unit'

# This test uses the chart from pinyin.info to compare all implemented conversion types
# Since I can't find another reference of the hanyu pinyin 'lo', I have removed it from the table

class TestCompare < Test::Unit::TestCase
  CHART_FILE = File.expand_path('../../lib/ting/data/comparison.csv', __FILE__)
  COMPARE=[:hanyu, :wadegiles, :zhuyin, :tongyong]

  # Both Rubinius and JRuby are having trouble parsing our otherwise valid UTF-8 CSV file.
  # See https://github.com/jruby/jruby/issues/563 for the JRuby issue that logs the issue.
  # So we do our own naive CSV parsing here.
  CHART = begin
            File.open(CHART_FILE, 'r:UTF-8').each_line.map do |line|
              line.strip.split(',').map{|entry| entry[/\A"(.*)"\z/, 1]}
            end
          end



  # Test all combinations, included parsing/unparsing the same type

  def test_do_comparisons
    COMPARE.each do |from|
      COMPARE.each do |to|
        compare(from,to)
      end
    end
  end

  def compare(from, to)
    reader = Ting.reader(from, :no_tones)
    writer = Ting.writer(to, :no_tones)

    ifrom = CHART[0].index from.to_s
    ito   = CHART[0].index to.to_s

    CHART[1..-1].each do |vals|
      assert_equal(vals[ito].strip, writer << (reader << vals[ifrom].strip), "Converting `#{vals[ifrom]}' from #{from} to #{to} value #{vals[ito]}")
    end
  end
end
