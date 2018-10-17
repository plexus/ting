# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ting::HanyuPinyinParser do
  let(:parser) { Ting::HanyuPinyinParser.new }

  it 'should be able to parse boring characters' do
    pinyin = "xíbié de hǎi'àn"
    expect(parser.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Xi,    Ting::Final::I,  2 ),
      Ting::Syllable.new( Ting::Initial::Bo,    Ting::Final::Ie, 2 ),
      Ting::Syllable.new( Ting::Initial::De,    Ting::Final::E,  5 ),
      Ting::Syllable.new( Ting::Initial::He,    Ting::Final::Ai, 3 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::An, 4 ),
    ])
  end

  it 'should be able to parse erhua' do
    pinyin = "wèir Wèir"
    expect(parser.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Ui, 4 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 5 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Ui, 4 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 5 ),
    ])
  end

  it 'should be able to discern erhua from other Ri syllables' do
    pinyin = Ting.pretty_tones 'yang2rou4'
    expect(parser.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Iang, 2 ),
      Ting::Syllable.new( Ting::Initial::Ri,    Ting::Final::Ou,   4 ),
    ])

    pinyin = Ting.pretty_tones 'sui1ran2'
    expect(parser.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Si, Ting::Final::Ui, 1 ),
      Ting::Syllable.new( Ting::Initial::Ri, Ting::Final::An, 2 ),
    ])
  end

  it 'should parse er4 and her2 correctly' do
    expect(parser.parse('èr')).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 4 ),
    ])
    expect(parser.parse('hér')).to eq([
      Ting::Syllable.new( Ting::Initial::He,    Ting::Final::E,  2 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 5 ),
    ])
  end

  it 'should parse ou1zhou1 correctly' do
    pinyin = Ting.pretty_tones('ou1zhou1')
    expect(parser.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Ou, 1 ),
      Ting::Syllable.new( Ting::Initial::Zhi,   Ting::Final::Ou, 1 ),
    ])
  end

  it 'should parse sheng3lve4 correctly' do
    expect(parser.parse('shěnglüè')).to eq([
      Ting::Syllable.new( Ting::Initial::Shi, Ting::Final::Eng, 3 ),
      Ting::Syllable.new( Ting::Initial::Le,  Ting::Final::Ue,  4 ),
    ])
  end

  it 'should parse regardless of apostrophes and weird whitespace' do
    pinyin = "Xī'ān\thǎowánr\tma?\nHǎowánr!"
    expect(parser.parse(pinyin).map(&:tone)).to eq([1, 1, 3, 2, 5, 5, 3, 2, 5])
  end

  it 'should parse ambiguous syllables based on context' do
    pinyin = 'gūnánguǎnǚ'
    expect(parser.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Ge, Ting::Final::U,  1 ),
      Ting::Syllable.new( Ting::Initial::Ne, Ting::Final::An, 2 ),
      Ting::Syllable.new( Ting::Initial::Ge, Ting::Final::Ua, 3 ),
      Ting::Syllable.new( Ting::Initial::Ne, Ting::Final::V,  3 ),
    ])

    pinyin = 'yángròu'
    expect(parser.parse(pinyin)).to eq([
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Iang, 2 ),
      Ting::Syllable.new( Ting::Initial::Ri,    Ting::Final::Ou,   4 ),
    ])
  end
  
  it 'should parse some invalid pinyin (missing apostrophe)' do
    # Syllables that begin with [aeo] must be prefixed with an apostrophe in the middle of the word.
    # Ref.: https://en.wikipedia.org/wiki/Pinyin#Pronunciation_of_initials, "Note on the apostrophe"
    # Still, Ting should be able to parse these syllables if they follow unambiguous characters.

    expect(parser.parse('hǎiàn')).to eq([
      Ting::Syllable.new( Ting::Initial::He,    Ting::Final::Ai, 3 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::An, 4 ),
    ])

    expect(parser.parse('mòshuǐer')).to eq([
      Ting::Syllable.new( Ting::Initial::Mo,    Ting::Final::O,  4 ),
      Ting::Syllable.new( Ting::Initial::Shi,   Ting::Final::Ui, 3 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::Er, 5 ),
    ])

    expect(parser.parse('gōngānjú')).to eq([
      Ting::Syllable.new( Ting::Initial::Ge,    Ting::Final::Ong, 1 ),
      Ting::Syllable.new( Ting::Initial::Empty, Ting::Final::An,  1 ),
      Ting::Syllable.new( Ting::Initial::Ji,    Ting::Final::V,   2 ),
    ])
  end
end
