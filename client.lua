--[[--------------VUtils-------------------
Version: 1.0a                   Author: LEO
Github: https://github.com/Leobrtl/vutils  
Discord: LEO#8641         Twitter: @leobrtl
  WARNING: If you edit anything in Vutils  
       no support will be available.       
            You're been warned.      

ACTUAL FEATURE:
• Seatbelt system
• Engine On/Off System
• Simple Radio
• Vehicle Lightning System
• Add SeatD Script (Change places in the vehicle without leaving there)
• Turn Light
• Vehicle Speedometer
• Repair Command System
• Nitro System => AttachVehicleNitro(vehicle, true/false) -- SERVER

PLANNED FEATURE (TO-DO):

• 3D Model for Seatbelt
• Fuel system (Dynamics Fuel Capacity ) and Fuel Station
• Pickable Fuel Can (3D Models) -- NOT SOON xD
• Damage system (Crash when vehicle health equals 0)
• Repair system (Repair kit item) + Need to Open Trunk for repair
• Vehicle Speedlimiter -- NOT SOON xD


------------------VUtils-----------------]]


local seatbeltIsActive = 0
local vehicleId = nil
local vehengine = 1
local LastSoundPlayed = 0
local track = 0
local radioStatus = 0
local VehicleLight = 0
local ply = nil
local CarUI


local function OnPackageStart()

	--[[CREATE CAR-UI TO DISPLAY INFORMATION ]]
	CarUI = CreateWebUI(0.0,0.0,0.0,0.0, 5, 16)
	LoadWebFile(CarUI, "http://asset/"..GetPackageName().."/car-ui/ui.html")
	SetWebVisibility(CarUI, WEB_HIDDEN)
    SetWebAnchors(CarUI, 0, 0, 1, 1)
    SetWebAlignment(CarUI, 0, 0)

    CreateTimer(function()
        UpdateSpeedometer()
    end, 30)

end
AddEvent("OnPackageStart", OnPackageStart)

--[[ KEYPRESS EVENT ]]
function VU_OnKeyPress(key)

	if not IsPlayerInVehicle() then
		return
	end
	if key == "K" then
		if seatbeltIsActive == 1 then
			DesactivateSeatBelt()
			seatbeltIsActive = 0
		else
			ActivateSeatBelt()
			seatbeltIsActive = 1
		end
	end
	if key == "C" then
		if vehengine == 0 then
			ExecuteWebJS(CarUI,"SetInfo('vu-engine', 'on');")
			CallRemoteEvent("SetVehicleEngineState", playerid, vehicleId)
			vehengine = 1
		elseif vehengine == 1 then
			StopRadio()
			ExecuteWebJS(CarUI,"SetInfo('vu-engine', 'off');")
			CallRemoteEvent("SetVehicleEngineState", playerid, vehicleId)
			vehengine = 0
		end
	end
	if key == "V" then

            if radioStatus == 1 then
            	StopRadio()
            elseif radioStatus == 0 then
            	StartRadio()
            end
	end
	if key == "L" then
		local vehicle = GetPlayerVehicle()
		if  VehicleLight == 0 then
			ExecuteWebJS(CarUI,"SetInfo('vu-lightning', 'on');")
			VehicleLight = 1
		elseif VehicleLight == 1 then
			ExecuteWebJS(CarUI,"SetInfo('vu-lightning', 'off');")
			VehicleLight = 0
		end
	end

end
AddEvent("OnKeyPress", VU_OnKeyPress)

--[[ BASE CAR UI ]]

AddEvent("OnPlayerEnterVehicle", function(playerid, vehicle, seat)
	local ply = playerid
	SetWebVisibility(CarUI, WEB_HITINVISIBLE)
	vehengine = 0
	CallRemoteEvent("TurnOffVehicleEngine", playerid, vehicle)
	if seatbeltIsActive == 0 then
	CallRemoteEvent("SendAudioFile","alarm.mp3", 0.08)
	end
end)
AddEvent("OnPlayerLeaveVehicle", function(playerid, vehicle, seat)
	ExecuteWebJS(CarUI,"SetInfo('vu-engine', 'off');")
	SetWebVisibility(CarUI, WEB_HIDDEN)
	DestroySound(LastSoundPlayed)
	CallRemoteEvent("TurnOnVehicleEngine", playerid, vehicle)
	if vehengine == 0 then
		CallRemoteEvent("TurnOnVehicleEngine", playerid, vehicle)
	else
		CallRemoteEvent("TurnOffVehicleEngine", playerid, vehicle)
	end

	DestroySound(track)
end)




--[[ SEATBELT  ]]


function ActivateSeatBelt(player)
	ExecuteWebJS(CarUI,"SetInfo('vu-seatbelt', 'on');")
	CallRemoteEvent("SendAudioFile","effect.mp3", 0.04)

end
function DesactivateSeatBelt(player)
	ExecuteWebJS(CarUI,"SetInfo('vu-seatbelt', 'off');")
	CallRemoteEvent("SendAudioFile","alarm.mp3", 0.08)
	
end

function PlayAudioFile(file, volume)
   DestroySound(LastSoundPlayed)

   LastSoundPlayed = CreateSound("audio/"..file)
   SetSoundVolume(LastSoundPlayed, volume)
end
AddRemoteEvent("PlayAudioFile", PlayAudioFile)


AddFunctionExport("VU_ActivateSeatbelt", ActivateSeatBelt)
AddFunctionExport("VU_DesactivateSeatBelt", DesactivateSeatBelt)





--[[ RADIO SYSTEM 
THIS IS AN IMPLEMENTATION
RADIO SYSTEM CREATED BY FINN
ONSET LINK: https://forum.playonset.com/forum/onset/scripting/releases/1503-ingame-radio-music-in-cars-while-on-the-road
]]

function StopRadio()
                ExecuteWebJS(CarUI,"SetInfo('vu-radio', 'off');")
                DestroySound(track)
                radioStatus = 0
end

function StartRadio()
                ExecuteWebJS(CarUI,"SetInfo('vu-radio', 'on');")
                local tracknumber = Random(1,3)
                radioStatus = 1
                CallRemoteEvent("SendTrackFile","track"..tracknumber..".mp3", 0.10)
                
end

function PlayTrackFile(file, volume)
   DestroySound(track)

   track = CreateSound("radio/"..file)
   SetSoundVolume(track, volume)
end
AddRemoteEvent("PlayTrackFile", PlayTrackFile)

AddEvent("OnPlayerLeaveVehicle", function(playerid, vehicle, seat)

    DestroySound(track)
    radioStatus = 0

end)


--[[ SPEEDOMETER ]]


function UpdateSpeedometer()

	local vehiclespeed = math.floor(GetVehicleForwardSpeed(GetPlayerVehicle()))
	ExecuteWebJS(CarUI,"SetSpeedometer('vu-speedometer', '"..vehiclespeed.."');")
end