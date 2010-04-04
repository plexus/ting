class String
  def chars
    self.unpack('U*').map{|c| [c].pack('U')}
  end

  def camelcase
    str = dup
    str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
    str.gsub!(/(\A|\s)([a-z])/){ $1 + $2.upcase }
    str
  end
end

module Kernel
  def returning(s)
    yield(s)
    s
  end
end
