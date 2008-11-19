class String
  def chars
    self.unpack('U*').map{|c| [c].pack('U')}
  end
end

module Kernel
  def returning(s)
    yield(s)
    s
  end
end
