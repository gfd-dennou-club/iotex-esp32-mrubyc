# coding: utf-8

i2c = I2C.new(22, 21)
mcp = MCP9808.new(i2c)
lcd = LCD.new(i2c)
lcd.init

if (!mcp.init())
  puts "Couldn't find MCP9808!"
  while true
    sleep(0.250)
  end 
end 

while true
  # puts "wake up MCP9808"
  mcp.shutdown_wake(false)
  c = mcp.readTempC()
  puts "Temp:#{c}*C"
  temp = sprintf("%.1f*C",c)
  sleep(0.250)
  lcd.cursor(2, 0)
  lcd.print("TEMP")
  lcd.cursor(1,1)
  lcd.print(temp)
  sleep(1)
  lcd.clear()
  # puts "Shutdown MCP9808"
  mcp.shutdown_wake(true)
  sleep(0.5)
end
