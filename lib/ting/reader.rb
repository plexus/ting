module Ting
  class Reader
    include Procable

    def initialize(conv, tone)
      @conv = conv.to_s
      @tone = Tones.const_get Ting.camelize(tone.to_s)
    end

    def parse(str)
      Conversions.tokenize(str).map do |token, pos|
        tone, syll = @tone.pop_tone(token)
        tsyll = Conversions.parse(@conv, syll)
        ini, fin = tsyll.initial, tsyll.final
        unless tone && fin && ini
          raise ParseError.new(token, pos),"Illegal syllable <#{token}> in input <#{str}> at position #{pos}."
        end
        tsyll + tone
      end
    rescue Object => e
      raise ParseError.new(str, 0, e), "Parsing of #{str.inspect} failed : #{e}"
    end

    alias :<< :parse
    alias :call :parse
  end
end
