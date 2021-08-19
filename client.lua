local wait = Config.FirstJoinDelay
Citizen.CreateThread(function()
	Citizen.Wait(wait)
	while true do
		TriggerServerEvent('sendSession:PlayerNumber', #GetActivePlayers())
		Citizen.Wait(wait)
	end
end)

secondsUntilKick = Config.AfkTime

kickWarning = Config.AfkWarning

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "AFK Kick", {255, 0, 0}, {255, 255, 255}, " ^1Za " .. time .. " sekund budes odpojen z duvodu AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end
			prevPos = currentPos
		end
	end
end)

-- Ping Kick

Citizen.CreateThread(function()
	while true do
		Wait(Config.PingCheckDelay)

		TriggerServerEvent("checkMyPingBro")
	end
end)

RegisterCommand('afkreset', function(source, args)
    time = secondsUntilKick
	TriggerEvent("chatMessage", "AFK Kick", {255, 0, 0}, {255, 255, 255}, " ^0Cas pro vyhozeni ze hry byl obnoven na 30 minut!")
end)