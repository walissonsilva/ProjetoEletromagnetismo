SDA = 1
SCL = 2
ADDRESS = 0x3c
 
i2c.setup(0, SDA, SCL, i2c.SLOW)
disp = u8g.ssd1306_128x64_i2c(ADDRESS)
 
function draw()
  disp:setFont(u8g.font_6x10)
  disp:drawStr(34, 10, "FILIPEFLOP")
  disp:drawLine(0, 25, 128, 25);
  disp:setFont(u8g.font_chikita)
  disp:drawStr(30, 40, "Blog FILIPEFLOP")
  disp:drawStr(20, 50, "Tutoriais e Projetos")
  disp:drawStr(38, 60, "com Arduino")
end
 
function loop()
  disp:firstPage()
 
  repeat
    draw()
  until disp:nextPage() == false
 
  -- devemos chamar tmr.wdclr() em um loop contínuo
  -- para evitar hardware reset causado pelo watchdog.
  tmr.wdclr()
  loop()
end
 
loop()