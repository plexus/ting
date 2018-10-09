# -*- coding: utf-8 -*-
# Classes and constants used throughout the module
#  * Initial
#  * Final
#  * Syllable
#  * ILLEGAL_COMBINATIONS

require 'yaml'

module Ting

  #
  # A Chinese initial (start of a syllable)
  #

  class Initial
    attr :name

    def initialize(n) ; @name=n ; end

    All = %w(
      Empty Bo Po Mo Fo De Te Ne Le Ge Ke He
      Ji Qi Xi Zhi Chi Shi Ri Zi Ci Si
      ).map{|c| const_set c, Initial.new(c)}

    class << self
      private :new
      include Enumerable
      def each(&blk) ; All.each(&blk) ; end
    end

    Groups=[
            Group_0=[ Empty ],
            Group_1=[ Bo,Po,Mo,Fo],     #Bilabial and Labio-dental
            Group_2=[ De,Te,Ne,Le ],    #Plosive, nasal and lateral approximant alveolar
            Group_3=[ Ge,Ke,He ],       #Velar
            Group_4=[ Ji,Qi,Xi ],       #Alveolo-palatal
            Group_5=[ Zhi,Chi,Shi,Ri ], #Retroflex
            Group_6=[ Zi,Ci,Si ],       #Fricative and affricate alveolar
           ]

    def +(f)
      Syllable.new(self,f)
    end

    def inspect() ; "<#{self.class.name}::#{@name}>" ; end
  end


  #
  # A Chinese final (end of a syllable)
  #

  class Final
    attr :name

    def initialize(n) ; @name=n ; end

    All=%w(
      Empty A O E Ee Ai Ei Ao Ou An En Ang Eng Ong Er
      I Ia Io Ie Iai Iao Iu Ian In Iang Ing
      U Ua Uo Uai Ui Uan Un Uang Ueng V Ue Van Vn Iong
    ).map{|c| const_set c, Final.new(c)}

    class << self
      private :new
      include Enumerable
      def each(&blk) ; All.each(&blk) ; end
    end

    Groups=[
            Group_0=[ Empty ],
            Group_A=[ A,O,E,Ee,Ai,Ei,Ao,Ou,An,En,Ang,Eng,Ong,Er ],
            Group_I=[ I,Ia,Io,Ie,Iai,Iao,Iu,Ian,In,Iang,Ing ],
            Group_U=[ U,Ua,Uo,Uai,Ui,Uan,Un,Uang,Ueng ],
            Group_V=[ V,Ue,Van,Vn,Iong]
           ]

    def inspect() ; "<#{self.class.name}::#{name}>" ; end
  end


  #
  # Combination of an initial and a final, a tone, and possible capitalization
  # A tone of 'nil' means the tone is not specified

  class Syllable
    attr_accessor :initial, :final, :tone, :capitalized

    def initialize(initial, final, tone = nil, capitalized = false)
      self.initial     = initial
      self.final       = final
      self.tone        = tone
      self.capitalized = capitalized
    end

    def +(tone)
      self.class.new(self.initial, self.final, tone, self.capitalized)
    end

    def inspect
      "<#{self.class.name} <initial=#{initial.name}, final=#{final.name}, tone=#{tone}#{', capitalized' if capitalized}>>"
    end

    alias :capitalized? :capitalized

    def self.illegal?(i,f)
      ILLEGAL_COMBINATIONS.any? {|in_gr, fin_gr| in_gr.include?(i) && fin_gr.include?(f)}
    end

    alias :to_s :inspect

    def ==( other )
      return false unless other.is_a? Syllable

      [ other.initial, other.final, other.tone, other.capitalized ] ==
        [ self.initial, self.final, self.tone, self.capitalized ]
    end
  end

  #
  # Some groups of initials and finals may not be combined
  # This list is not exhaustive but is sufficient to resolve ambiguity
  #

  ILLEGAL_COMBINATIONS=
    [
     [Initial::Group_0, Final::Group_0],
     [Initial::Group_1, Final::Group_0],
     [Initial::Group_2, Final::Group_0],
     [Initial::Group_3, Final::Group_0],
     [Initial::Group_4, Final::Group_0],

     [Initial::Group_4, Final::Group_U],
     [Initial::Group_4, Final::Group_A],

     [Initial::Group_3, Final::Group_I],
     [Initial::Group_5, Final::Group_I],
     [Initial::Group_6, Final::Group_I],

     [Initial::Group_1, Final::Group_V],
     [Initial::Group_3, Final::Group_V],

     # For "咯 / lo5" to parse correctly we need to list "Le + O" as valid,
     [Initial::Group_2 - [Initial::Le], [Final::O]],  #Only bo, po, mo and fo are valid -o combinations
     [Initial::Group_3, [Final::O]],
     [Initial::Group_4, [Final::O]],
     [Initial::Group_5, [Final::O]],
     [Initial::Group_6, [Final::O]],

     [[Initial::Empty], [Final::Ong]]
       # TODO: Ong is actually the same as Ueng, in Hanyu Pinyin : -ong or weng
    ]

  class << self

    #
    # Yields a block for any valid initial/final pair
    #

    def valid_combinations( &blk )
      return to_enum(__method__) unless block_given?
      inp = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'data', 'valid_pinyin.yaml')))
      inp.each do |final, initials|
        final = Final.const_get(final)
        initials.each do |initial, pinyin|
          initial = Initial.const_get(initial)
          yield [initial, final]
        end
      end
    end

    def all_syllables( &blk )
      return to_enum(__method__) unless block_given?
      valid_combinations.map do |i,f|
        1.upto(5) do |t|
          yield Syllable.new(i,f,t,false)
          yield Syllable.new(i,f,t,true)
        end
      end
    end
  end
end
