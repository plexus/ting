class String
  PINYIN_CACHE={}
  def pretty_tones
    self.gsub('u:','ü').gsub(/[A-Za-züÜ]{1,5}\d/) do |m|
      m.downcase!
      PINYIN_CACHE[m] || PINYIN_CACHE[m]=(Pinyin.HanyuWriter(:accents) << Pinyin.HanyuReader(:numbers).parse(m.downcase))
    end
  end

  def bpmf
    self.gsub('u:','ü').scan(/[A-Za-züÜ]{1,5}\d/).map do |m|
      Pinyin.ZhuyinWriter(:marks) << 
        (Pinyin.HanyuReader(:numbers) << m.downcase)
    end.join(' ')
  end
end
