pinyin
    by Arne Brasseur

== DESCRIPTION:

Pinyin can convert between various systems for phonetically
writing Mandarin Chinese. It can also handle various representation
of tones, so it can be used to convert pinyin with numbers
to pinyin with tones.

Supported formats include Hanyu Pinyin, Bopomofo, Wade-Giles
and International Phonetic Alphabet (IPA).

== FEATURES/PROBLEMS:
  
== SYNOPSIS:

   require 'pinyin'

   reader = Pinyin::Reader.new(:hanyu, :tones)
   reader << "wo3 ai4 ni3"
    # => [<Pinyin::Syllable <initial=Empty, final=Uo, tone=3>>, 
    #     <Pinyin::Syllable <initial=Empty, final=Ai, tone=4>>, 
    #     <Pinyin::Syllable <initial=Ne, final=I, tone=3>>]

   writer = Pinyin::Writer.new(:zhuyin, :marks)
   
   writer << (reader << "wo3 ai4 ni3")
   # => "ㄨㄛˇ ㄞˋ ㄋㄧˇ"

   require 'pinyin/string'

   "wo3 ai4 ni3".pretty_tones
   # => "wǒ ài nǐ"

== REQUIREMENTS:

* $KCODE has to be set to "UTF8" for everything to work correctly
* Facets

== INSTALL:

* gem install pinyin

== LICENSE:
Copyright (c) 2004-2007, Arne Brasseur. (http://www.arnebrasseur.net)

Available as Free Software under the GPLv3 License, see LICENSE.txt for
details

