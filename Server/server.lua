-- NodeMCU
-- Server

-- LEDs
DHT11 = 1; -- GPIO0
temp_anterior = 0;
LAMP = 0; -- GPIO2

gpio.mode(LAMP, gpio.OUTPUT);
gpio.write(LAMP, gpio.LOW);
--

-- Configurando o modo de operacao do wifi
wifi.setmode(wifi.SOFTAP);
cfg={}
cfg.ssid = "ESP"
cfg.pwd = "eletromagnetismo"
wifi.ap.config(cfg)
--

-- Imprimir o endereco de IP do servidor
print("Server IP Address: ", wifi.ap.getip());

sv = net.createServer(net.TCP, 28800) 
sv:listen(80, function(conn)
    conn:on("receive", function(conn, dadoRecebido) 
        if (dadoRecebido == "LAMP_ON") then
            gpio.write(LAMP, gpio.HIGH);
        elseif (dadoRecebido == "LAMP_OFF") then
            gpio.write(LAMP, gpio.LOW);
        end
    end)

    conn:on("sent", function(con) 
      --conn:close()
      --tmr.stop(0)
      collectgarbage()
    end)

    tmr.alarm(0, 10000, 1, function() 
      getTemp()
      print(temp_anterior)
      conn:send(temp_anterior);
    end)

    conn:on("connection", function(sck, c) 
        print("Conectoooouuuu... =)")

    end)
end)

function getTemp()
    status, temp, humi, temp_dec, humi_dec = dht.read(DHT11);
    
    if status == dht.OK then
        temp_anterior = temp;
    end

    temp = temp_anterior;
end
