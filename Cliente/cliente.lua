-- ESP01
-- CLIENTE

wifi.sta.disconnect()
wifi.setmode(wifi.STATION) 
wifi.sta.config("ESP","eletromagnetismo")
wifi.sta.autoconnect(1)

cl = net.createConnection(net.TCP, 0)

cl:on("receive", function(sck, temp_recebida)
     display(temp_recebida)
end)

tmr.alarm(0, 1000, 1, function()
    print("Tentando conectar!")
    cl:connect(80,"192.168.4.1")
end)

cl:on("connection", function(sck,c)
    init_i2c_display()
    print("Conectado")
    tmr.stop(0)
end)

cl:on("disconnection", function(sck,c)
    print("Caiu! :(")
    cl:close();
    collectgarbage();
    tmr.start(0)
end)

function init_i2c_display()
     i2c.setup(0, 3, 4, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(0x3c)
end

-- A rotina para desenhar no display
function draw(temp_recebida)
  disp:setFont(u8g.font_6x10);
  disp:drawStr( 32, 15, "TEMPERATURA");

  print(temp_recebida);

  escrever_primeiro(string.sub(temp_recebida, 1, 1));
  escrever_segundo(string.sub(temp_recebida, 2));

  -- Graus Celsius
  disp:drawCircle(92, 30, 4);
  disp:drawCircle(92, 30, 3);
  disp:drawHLine(97, 40, 11);
  disp:drawHLine(96, 41, 13);
  disp:drawHLine(95, 42, 15);
  disp:drawVLine(95, 42, 10);
  disp:drawVLine(96, 41, 12);
  disp:drawVLine(97, 40, 14);
  disp:drawHLine(95, 52, 15);
  disp:drawHLine(96, 53, 13);
  disp:drawHLine(97, 54, 11);
  disp:drawRFrame(0, 20, 128, 44, 4);
end

function display(temp_recebida)
    disp:firstPage()
    repeat
       draw(temp_recebida)
    until disp:nextPage() == false
end

function escrever_primeiro(primeiro)
    if (primeiro == '2') then
        dofile("dois_e.lua");
    elseif (primeiro == '3') then
        dofile("tres_e.lua");    
    else
        dofile("quatro_e.lua")
    end
end

function escrever_segundo(segundo)
    if (segundo == '0') then
        dofile("zero.lua");  
    elseif (segundo == '1') then
        dofile("um.lua");
    elseif (segundo == '2') then
        dofile("dois.lua");
    elseif (segundo == '3') then
        dofile("tres.lua");
    elseif (segundo == '4') then
        dofile("quatro.lua");
    elseif (segundo == '5') then
        dofile("cinco.lua");
    elseif (segundo == '6') then
        dofile("seis.lua");
    elseif (segundo == '7') then
        dofile("sete.lua");
    elseif (segundo == '8') then
        dofile("oito.lua");
    elseif (segundo == '9') then
        dofile("nove.lua");
    end
end

