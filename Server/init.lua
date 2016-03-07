-- Server

-- LEDs
LEDG = 3; -- GPIO0
LEDR = 4; -- GPIO2

gpio.mode(LEDG, gpio.OUTPUT);
gpio.mode(LEDR, gpio.OUTPUT);
--

-- Configurando o modo de operacao do wifi
wifi.setmode(wifi.STATIONAP);
cfg={}
cfg.ssid = "ESP01"
cfg.pwd = "eletromagnetismo"
wifi.ap.config(cfg)
--

-- Imprimir o endereco de IP do servidor
print("Server IP Address: ", wifi.ap.getip());

sv = net.createServer(net.TCP) 
sv:listen(80, function(conn)
    conn:on("receive", function(conn, dadoRecebido) 
        if (dadoRecebido == "LEDG") then
            gpio.write(LEDG, gpio.HIGH);
            gpio.write(LEDR, gpio.LOW);
        elseif (dadoRecebido == "LEDR") then
            gpio.write(LEDR, gpio.HIGH);
            gpio.write(LEDG, gpio.LOW);
        end
    end)
    
    conn:on("sent", function(conn) 
      collectgarbage()
    end)
end)
