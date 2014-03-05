module Ting
  class Converter
    include Procable

    attr_reader :from_conv, :from_tone, :to_conv, :to_tone

    def initialize(from, from_tone, to, to_tone)
      @from_conv, @from_tone, @to_conv, @to_tone = from, from_tone, to, to_tone
    end

    def reader
      @reader ||= Reader.new(from_conv, from_tone)
    end

    def writer
      @writer ||= Writer.new(to_conv, to_tone)
    end

    def convert(str)
      writer.unparse reader.parse(str)
    end

    def to(to, to_tone)
      Converter.new(self.from_conv, self.from_tone, to, to_tone)
    end

    alias :<< :convert
    alias :call :convert
  end
end
