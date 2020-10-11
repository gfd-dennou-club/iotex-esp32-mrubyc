# AQM0802A-RN-GBW
#
# I2C address : 0x3e

class AQM0802A
  
  def initialize(i2c)
    @i2c = i2c
  end

  def setup
    @i2c.write(0x3e, [])
    sleep(1)
    @i2c.write(0x3e, [])
  end

  def clear
    @i2c.write(0x3e, [])
  end

  def cursor(x, y)
    @i2c.write(0x3e, [])
  end

  def write_string(s)
    a = Array.new
    a.push(0x40)
    s.length.times do |n|
      a.push(s[n].ord)
    end
    @i2c.write(0x3e, a)
  end

end
