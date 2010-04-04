require 'ting'
require 'test/unit'
require 'csv'


# This test uses the chart from piyin.info to compare all implemted conversion types
# Since I can't find another reference of the hanyu pinyin 'lo', I have removed it from the table

class TestCompare < Test::Unit::TestCase
  CHART=CSV.parse(IO.read(File.dirname(__FILE__)+'/../lib/ting/data/comparison.csv'))
  COMPARE=[:hanyu, :wadegiles, :zhuyin, :tongyong]


  # Test all combinations, included parsing/unparsing the same type

  def test_do_comparisons
    COMPARE.each do |from|
      COMPARE.each do |to|
        compare(from,to)
      end
    end
  end

  def compare(from, to)
    reader = Ting::Reader.new(from, :no_tones)
    writer = Ting::Writer.new(to, :no_tones)

    ifrom = CHART[0].index from.to_s
    ito   = CHART[0].index to.to_s

    CHART[1..-1].each do |vals|
      assert_equal(vals[ito].strip, writer << (reader << vals[ifrom].strip), "Converting from #{from} to #{to} value #{vals[ito]}")
    end
  end
end
