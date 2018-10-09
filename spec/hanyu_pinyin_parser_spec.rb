# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ting::HanyuPinyinParser do
  it 'should be able to parse boring characters' do
    pinyin = Ting.pretty_tones "Xi2bie2 de Hai3an4"
    expect(Ting::HanyuPinyinParser.new.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Xi,    Ting::Final::I,  2 ),
      Ting::Syllable.new( Ting::Initial::Bo,    Ting::Final::Ie, 2 ),
      Ting::Syllable.new( Ting::Initial::De,    Ting::Final::E,  5 ),
      Ting::Syllable.new( Ting::Initial::He,    Ting::Final::Ai, 3 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::An, 4 ),
    ])
  end

  it 'should be able to parse erhua' do
    pinyin = "wèir Wèir"
    expect(Ting::HanyuPinyinParser.new.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Ui, 4 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 5 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Ui, 4 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 5 ),
    ])
  end

  it 'should be able to discern erhua from other Ri syllables' do
    pinyin = Ting.pretty_tones "yang2rou4"
    expect(Ting::HanyuPinyinParser.new.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Iang, 2 ),
      Ting::Syllable.new( Ting::Initial::Ri,    Ting::Final::Ou,   4 ),
    ])

    pinyin = Ting.pretty_tones "sui1ran2"
    expect(Ting::HanyuPinyinParser.new.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Si, Ting::Final::Ui, 1 ),
      Ting::Syllable.new( Ting::Initial::Ri, Ting::Final::An, 2 ),
    ])
  end

  it 'should parse er4 correctly' do
    expect(Ting::HanyuPinyinParser.new.parse("èr")).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 4 ),
    ])
  end

  it 'should parse Ou1zhou1 correctly' do
    pinyin = Ting.pretty_tones("ou1zhou1")
    expect(Ting::HanyuPinyinParser.new.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Ou, 1 ),
      Ting::Syllable.new( Ting::Initial::Zhi,   Ting::Final::Ou, 1 ),
    ])
  end

  it 'should parse regardless of apostrophes and weird whitespace' do
    pinyin = "Xī'ān\thǎowánr\tma?\nHǎowánr!"
    expect(Ting::HanyuPinyinParser.new.parse(pinyin).map(&:tone)).to eq([1, 1, 3, 2, 5, 5, 3, 2, 5])
  end
end
