-- Cliente



wifi.sta.disconnect()
wifi.setmode(wifi.STATION) 
wifi.sta.config("ESP01","eletromagnetismo")
wifi.sta.connect() 

tmr.alarm(1, 2000, 1, function()
     if(wifi.sta.getip() ~= nil) then
          tmr.stop(1)
          print("Connected!")
          print("Client IP Address:", wifi.sta.getip())
          cl = net.createConnection(net.TCP, 0)
          cl:connect(80,"192.168.4.1")
          tmr.alarm(2, 5000, 0, function() 
            cl:send("LEDG");
          end)
      else
         print("Connecting...")
      end
end)
