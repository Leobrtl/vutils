--[[--------------VUtils-------------------
Version: 1.0a                   Author: LEO
Github: https://github.com/Leobrtl/vutils  
Discord: LEO#8641         Twitter: @leobrtl
  WARNING: If you edit anything in Vutils  
       no support will be available.       
            You're been warned.      
------------------VUtils-----------------]]
            function OnKeyPress(key)
	if not IsPlayerInVehicle() then
		return
	end
	if key == "Ampersand" then
		CallRemoteEvent("ChangeSeat", 1)
	elseif key == "é" then
		CallRemoteEvent("ChangeSeat", 2)
	elseif key == "Quote" then
		CallRemoteEvent("ChangeSeat", 3)
	elseif key == "Apostrophe" then
		CallRemoteEvent("ChangeSeat", 4)
	end
end
AddEvent("OnKeyPress", OnKeyPress)