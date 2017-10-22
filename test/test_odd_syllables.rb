require 'ting'
require 'test/unit'

class TestOddSyllables < Test::Unit::TestCase
  def test_zhuyin_conversion
    pinyin_to_zhuyin = Ting::Converter.new(:hanyu, :numbers, :zhuyin, :marks)
    zhuyin_to_pinyin = Ting::Converter.new(:zhuyin, :marks, :hanyu, :numbers)
    
    # These syllable could not be converted to Zhuyin in Ting 0.9.
    %w(yo1 yai2).each do |pinyin|
      zhuyin = pinyin_to_zhuyin.convert(pinyin)
      pinyin2 = zhuyin_to_pinyin.convert(zhuyin)
      assert_equal pinyin, pinyin2
    end
  end
end
