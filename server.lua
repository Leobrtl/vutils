--[[--------------VUtils-------------------
Version: 1.0a                   Author: LEO
Github: https://github.com/Leobrtl/vutils  
Discord: LEO#8641         Twitter: @leobrtl
  WARNING: If you edit anything in Vutils  
       no support will be available.       
            You're been warned.      
------------------VUtils-----------------]]
function OnPackageStart()

	print("")
	print("")
	print("")
	print("--<<-----------[[-VUtils-]]------------>>--")
	print("Version: 1.0a                   Author: LEO")
	print("Github: https://github.com/Leobrtl/vutils  ")
	print("Discord: LEO#8641         Twitter: @leobrtl")
	print("  WARNING: If you edit anything in Vutils  ")
	print("       no support will be available.       ")
	print("            You're been warned.            ")
	print("--<<-----------[[-VUtils-]]------------>>--")
	print("")
	print("")
	print("")

end
AddEvent("OnPackageStart", OnPackageStart)

local ply = nil
function OnPlayerJoin(player)
	print("[VUtils] Script Started version 1.0a for player: "..GetPlayerName(player))
   ply = player

end
AddEvent("OnPlayerJoin", OnPlayerJoin)


function SendAudioFile(player, file, volume)
   CallRemoteEvent(player, "PlayAudioFile", file, volume)
end
AddRemoteEvent("SendAudioFile", SendAudioFile)

function SendTrackFile(player, file, volume)
	local vehicle = GetPlayerVehicle(ply)
   CallRemoteEvent(player, "PlayTrackFile", file, volume, vehicle)
end
AddRemoteEvent("SendTrackFile", SendTrackFile)

AddRemoteEvent("SetVehicleEngineState", function(player, vehicle)
	local guiname = "engine"
	local player_vehicle = GetPlayerVehicle(player)
	local stateb = GetVehiclePropertyValue(player_vehicle, "engine")
	if stateb == 1 then
		StartEngine(player)

	elseif stateb == 0 then
		StopEngine(player)

	elseif stateb == nil then
		StopEngine(player)
		SetVehiclePropertyValue(player_vehicle, "engine", 1)
		
	elseif stateb > 1 then
		print("[VUtils] An Error Occured with an function. Error code: VU_PROPERTY_ERR2")
	end

end)
AddRemoteEvent("TurnOffVehicleEngine", function(player, vehicle)
	StopEngine(player)
end)
AddRemoteEvent("TurnOnVehicleEngine", function(player, vehicle)
	StartEngine(player)
end)
function StopEngine(player)
   local veh = GetPlayerVehicle(player)
   if veh ~= 0 then
      StopVehicleEngine(veh)
      SetVehiclePropertyValue(veh, "engine", 1)
   end
end
function StartEngine(player)
   local veh = GetPlayerVehicle(player)
   if veh ~= 0 then
      StartVehicleEngine(veh)
      SetVehiclePropertyValue(veh, "engine", 0)
   end
end

AddRemoteEvent("VU:SetVehicleLight", function(player, vehicle, bool)
	if IsValidVehicle(vehicle) then
		if IsVehicleInWater(vehicle) then
			SetVehicleLightEnabled(vehicle, false)
		elseif bool == true or bool == false then
			SetVehicleLightEnabled(vehicle, bool)

		else
			print("[VUtils] An Error Occured with an function. Error code: VU_LIGHT_ERR3")
		end
	end
end)

AddFunctionExport("VU_StopEngine", StopEngine)
AddFunctionExport("VU_StartEngine", StartEngine)

AddCommand("repaircar", function(player)
	local vehicle = GetPlayerVehicle(player)
	Delay(1100, function()
		SetVehicleDamage(vehicle, 1, 0.0)
	end)
	Delay(1200, function()
		SetVehicleDamage(vehicle, 2, 0.0)
	end)
	Delay(1300, function()
		SetVehicleDamage(vehicle, 3, 0.0)
	end)
	Delay(1400, function()
		SetVehicleDamage(vehicle, 4, 0.0)
	end)
	Delay(1500, function()
		SetVehicleDamage(vehicle, 5, 0.0)
	end)
	Delay(1600, function()
		SetVehicleDamage(vehicle, 6, 0.0)
	end)
	Delay(1700, function()
		SetVehicleDamage(vehicle, 7, 0.0)
	end)
	Delay(1800, function()
		SetVehicleDamage(vehicle, 8, 0.0)
	end)
	Delay(1900, function()
		SetVehicleHealth(vehicle, 5000)
	end)
	AddPlayerChat(player, "Car Repaired.")
end)