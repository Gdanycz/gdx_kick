local prevPos = vector3(0,0,0)

Citizen.CreateThread(function()
	Citizen.Wait(Config.FirstJoinDelay)
	while true do
		TriggerServerEvent('sendSession:PlayerNumber', #GetActivePlayers())
		Citizen.Wait(Config.FirstJoinDelay)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		playerPed = PlayerPedId()
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)
            local diff = #(currentPos-prevPos)
			if diff < 0.5 then
				if time > 0 then
					if Config.AfkWarning and time == math.ceil(Config.AfkTime / 4) then
						chatMessage(_U('afk_warning_minutes', (time / 60)))
				    end

					if Config.AfkWarning and time <= 10 then
					    chatMessage(_U('afk_warning_seconds', time))
					end

					time = time - 1
				else
					TriggerServerEvent("gdx_kick:KickPlayer")
				end
			else
				time = Config.AfkTime
			end
			prevPos = currentPos
		end
	end
end)

-- Ping Kick
Citizen.CreateThread(function()
	while true do
		Wait(Config.PingCheckDelay)

		TriggerServerEvent("gdx_kick:CheckPing")
	end
end)

RegisterCommand(Config.AfkResetCMD, function(source, args)
    time = Config.AfkTime
    local timeToKick = time / 60
	chatMessage(_U('afk_reset', timeToKick))
end)

RegisterCommand(Config.AfkCheckCMD, function(source, args)
    chatMessage(_U('afk_check', (time / 60)))
end)

function chatMessage(message)
    TriggerEvent("chatMessage", "AFK Kick", {255, 0, 0}, {255, 255, 255}, message)
end
