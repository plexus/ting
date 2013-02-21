[![Build Status](https://travis-ci.org/arnebrasseur/ting.png)](https://travis-ci.org/arnebrasseur/ting) [![Code Climate](https://codeclimate.com/github/arnebrasseur/ting.png)](https://codeclimate.com/github/arnebrasseur/ting)

# Ting

Ting can convert between various systems for phonetically
writing Mandarin Chinese. It can also handle various representation
of tones, so it can be used to convert pinyin with numbers
to pinyin with tones.

Hanyu Pinyin, Bopomofo, Wade-Giles, Tongyong Pinyin
and International Phonetic Alphabet (IPA) are supported.

## SYNOPSIS

To parse your strings create a `Reader` object. Ting.reader() takes two
parameters : the transliteration format, and the way that tones are represented.

To some extent these can be mixed and matched.

To generate pinyin/wade-giles/etc. create a `Writer` object. Use Ting.writer()

### Formats

* `:hanyu` Hanyu Pinyin
* `:zhuyin` Zhuyin Fuhao (a.k.a. Bopomofo)
* `:wadegiles` Wade Giles
* `:ipa` International Phonetic Alphabet
* `:tongyong` Tongyong Pinyin

### Tones

* `:numbers` Simply put a number after the syllable, easy to type
* `:accents` Use diacritics, follows the Hanyu Pinyin rules, there needs to be at least one vowel to apply this to, not usable with IPA or Bopomofo
* `:supernum` Superscript numerals, typically used for Wade-Giles
* `:marks` Tone mark after the syllable, typically used for Bopomofo
* `:ipa` IPA tone marks
* `:no_tones` Use no tones

## Examples

Parse Hanyu Pinyin

````ruby
   require 'ting'

   reader = Ting.reader(:hanyu, :numbers)
   reader << "wo3 ai4 ni3"
    # => [<Ting::Syllable <initial=Empty, final=Uo, tone=3>>,
    #     <Ting::Syllable <initial=Empty, final=Ai, tone=4>>,
    #     <Ting::Syllable <initial=Ne, final=I, tone=3>>]
````

Generate Bopomofo

````ruby
   zhuyin = Ting.writer(:zhuyin, :marks)
   zhuyin << (reader << "wo3 ai4 ni3")
   # => "ㄨㄛˇ ㄞˋ ㄋㄧˇ"
````

Generate Wade-Giles

````ruby
   wadegiles = Ting.writer(:wadegiles, :supernum)
   wadegiles << (reader << "qing2 kuang4 ru2 he2")
   # => "ch`ing² k`uang⁴ ju² ho²"
````

Generate IPA

````ruby
   ipa = Ting.writer.new(:ipa, :ipa)
   ipa << (reader << "you3 peng2 zi4 yuan2 fang1 lai2")
   # => "iou˧˩˧ pʰeŋ˧˥ ts˥˩ yɛn˧˥ faŋ˥˥ lai˧˥"
````

Since this is such a common use case, a convenience method to add diacritics to pinyin.

````ruby
   require 'ting/string'

   "wo3 ai4 ni3".pretty_tones
   # => "wǒ ài nǐ"
````

Note that syllables need to be separated by spaces, feeding "peng2you3" to the parser
does not work. The String#pretty_tones method does handle these things a bit more gracefully.

If you need to parse input that does not conform, consider using a regexp to scan for valid
syllables, then feed the syllables to the parser one by one. Have a look at #pretty_tones for
an example of how to do this.

## REQUIREMENTS

* none, Ting uses nothing but Ruby

## INSTALL

* gem install ting

## LICENSE

Copyright (c) 2004-2010, Arne Brasseur. (http://www.arnebrasseur.net)

Available as Free Software under the GPLv3 License, see LICENSE.txt for details
