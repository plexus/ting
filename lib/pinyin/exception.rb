module Pinyin
  # All exceptions arising from this module inherit from Pinyin::Error
  Error = Class.new StandardError

  class ParseError < Error
    attr_reader :input, :position

    def initialize(input, position)
      @input=input
      @position=position
    end
  end
end
  
