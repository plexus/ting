module Ting
  class Writer
    include Procable

    def initialize(conv, tone)
      @conv = conv.to_s
      @tone = Tones.const_get Ting.camelize(tone.to_s)
    end

    def generate(syll)
      Array(syll).map do |s|
        syllable = Conversions.unparse(@conv, s)
        str = @tone.add_tone(syllable, s.tone)
        str.capitalize! if s.capitalized?
        str
      end.join(' ')
    end

    alias :<< :generate
    alias :unparse :generate
    alias :call :generate
  end
end
