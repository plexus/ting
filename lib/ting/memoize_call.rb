module Ting
  class MemoizeCall
    include Procable

    def initialize(target)
      @target = target
      @map = {}
    end

    def call(*args)
      @map[args] ||= @target.call(*args)
    end
  end
end
