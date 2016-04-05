function init_i2c_display()
     i2c.setup(0, 3, 4, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(0x3c)
end

-- A rotina para desenhar no display
function draw(temp_recebida)
  disp:setFont(u8g.font_6x10);
  disp:drawStr( 32, 15, "TEMPERATURA");
end

function display(temp_recebida)
    disp:firstPage()
    repeat
       draw(temp_recebida)
    until disp:nextPage() == false
end

init_i2c_display()
display()