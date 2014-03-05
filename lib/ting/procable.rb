module Ting
  module Procable
    def to_proc
      method(:call).to_proc
    end
  end
end
