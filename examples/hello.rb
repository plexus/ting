$: << File.join(File.dirname(__FILE__), '../lib')

require 'ting'

conv1 = Ting::Converter.new(:hanyu, :numbers, :wadegiles, :accents)
conv2 = Ting::Converter.new(:wadegiles, :accents, :zhuyin, :marks)

pinyin    = 'wo3 de peng2 you3 shi4 dai4 fu'
wadegiles = conv1 << pinyin
zhuyin    = conv2 << wadegiles

puts pinyin, wadegiles, zhuyin
