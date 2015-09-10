class Color

  attr_accessor :name, :red, :green, :blue

  def to_hex
    "\##{real_to_hex(@red)}#{real_to_hex(@green)}#{real_to_hex(@blue)}"
  end

  def real_to_hex(cmp)
    (cmp.to_f * 100).to_i.to_s(16)
  end

end
