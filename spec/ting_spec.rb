# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ting do
  let(:pinyin)   { 'dao4 ke3 dao4 fei1 chang2 dao4'.force_encoding('UTF-8') }
  let(:bopomofo) { 'ㄉㄠˋ ㄎㄜˇ ㄉㄠˋ ㄈㄟ ㄔㄤˊ ㄉㄠˋ'.force_encoding('UTF-8') }

  it 'should convert from Hanyu Pinyin to Bopomofo' do
    expect(Ting.from(:hanyu, :numbers).to(:zhuyin, :marks).convert(pinyin)).to eq(bopomofo)
  end

  it 'should parse' do
    expect(Ting::Reader.new(:hanyu, :numbers).parse('Bei3').first).to eq(Ting::Syllable.new( Ting::Initial::Bo, Ting::Final::Ei, 3, true ))
  end

  it 'should respect capitalization' do
    expect(Ting.from(:hanyu, :numbers).to(:hanyu, :accents).convert('Bei3 jing1')).to eq('Běi jīng')
  end
  
  it 'should parse syllables correctly' do
    expect(Ting.pretty_tones('wo3 de peng2you3 hen3 zhuang4')).to eq('wǒ de péngyǒu hěn zhuàng')
    expect(Ting.bpmf('wo3 de peng2you3 hen3 zhuang4')).to eq('ㄨㄛˇ ㄉㄜ˙ ㄆㄥˊ ㄧㄡˇ ㄏㄣˇ ㄓㄨㄤˋ')
  end
end
