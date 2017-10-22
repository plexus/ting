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

  def test_wg_conversion
    pinyin_to_wg = Ting::Converter.new(:hanyu, :numbers, :wadegiles, :numbers)
    wg_to_pinyin = Ting::Converter.new(:wadegiles, :numbers, :hanyu, :numbers)
    
    # These syllable could not be converted to Wade-Giles in Ting 0.9.
    %w(yo1 yai2).each do |pinyin|
      wg = pinyin_to_wg.convert(pinyin)
      pinyin2 = wg_to_pinyin.convert(wg)
      assert_equal pinyin, pinyin2
    end
  end
end
