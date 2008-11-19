$: << File.join(File.dirname(__FILE__), '../lib')

require 'pinyin'

conv1 = Pinyin::Converter.new(:hanyu, :numbers, :wadegiles, :accents)
conv2 = Pinyin::Converter.new(:wadegiles, :accents, :zhuyin, :marks)

pinyin    = 'wo3 de2 peng2 you3 shi4 dai4 fu'
wadegiles = conv1 << pinyin
zhuyin    = conv2 << wadegiles

puts pinyin, wadegiles, zhuyin
