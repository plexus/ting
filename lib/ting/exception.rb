module Ting

  # All exceptions arising from this module inherit from Ting::Error

  class Error < StandardError ; end

  class ParseError < Error
    attr_reader :input, :position

    def initialize(input, position)
      @input=input
      @position=position
    end
  end

end
  
