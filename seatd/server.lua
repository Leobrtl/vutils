--[[--------------VUtils-------------------
Version: 1.0a                   Author: LEO
Github: https://github.com/Leobrtl/vutils  
Discord: LEO#8641         Twitter: @leobrtl
  WARNING: If you edit anything in Vutils  
       no support will be available.       
            You're been warned.      
------------------VUtils-----------------]]
AddRemoteEvent("ChangeSeat", function(player, seat)

   local veh = tonumber(GetPlayerVehicle(player))
   local vehmodel = tonumber(GetVehicleModel(player))
   local seatplace = tonumber(seat)
   		if GetPlayerVehicleSeat(player) == seatplace then
   			print("[VUtils] Impossible to set seat because seat "..seatplace.." is the player seat")
   		else

   			if GetVehiclePassenger(veh, seatplace) > 0 then
   				print("[VUtils] Impossible to set seat because seat "..seatplace.." is used by another player")
   			else

   				SetPlayerInVehicle(player, veh, seatplace)
   			end
   		end


end)