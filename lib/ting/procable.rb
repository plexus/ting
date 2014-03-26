module Ting
  module Procable
    def to_proc
      method(:call).to_proc
    end

    def memoize
      MemoizeCall.new(self)
    end
  end
end
