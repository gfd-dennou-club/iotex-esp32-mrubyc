# coding: utf-8

class MCP9808

ADDRESS = 0x18

def initialize(i2c)
   @i2c = i2c
end
 
def write16(reg, value)
  @i2c.write(MCP9808::ADDRESS, reg, (value >> 8) & 0xFF, value & 0xFF)
end

def read16(reg)
  @i2c.write(MCP9808::ADDRESS, reg) 
  data = @i2c.read_integer(MCP9808::ADDRESS, 2)
  #p data
  value = (data[0] << 8) | data[1]

  value
end

def init() 
  if (read16(0x06) != 0x0054)
    puts "error1"
    return false
  end
  if (read16(0x07) != 0x0400)
    puts "error2"

    return false
  end

  write16(0x01, 0x0)
  true
end


def shutdown_wake(sw) 
  conf_register = read16(0x01);
  if (sw == true) 
    conf_shutdown = conf_register | 0x0100 
    write16(0x01, conf_shutdown)
  end 
  if (sw == false)
    conf_shutdown = conf_register & ~0x0100
    write16(0x01, conf_shutdown)
  end 
end

def readTempC()
  temp = nil
  t = read16(0x05)

  if (t != 0xFFFF) 
    temp = t & 0x0FFF
    temp /= 16.0
    if (t & 0x1000 != 0)
      temp -= 256
    end 
  end

  temp

end
end
