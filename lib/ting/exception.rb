module Ting

  class ParseError < StandardError
    attr_reader :input, :position

    def initialize(input, position, error = nil)
      super(error)
      @input=input
      @position=position
    end
  end

end
  
