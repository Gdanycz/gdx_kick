RegisterServerEvent("gdx_kick:KickPlayer")
AddEventHandler("gdx_kick:KickPlayer", function()
	DropPlayer(source, _U('afk_kick'))
end)


-- Ping Kick
RegisterServerEvent("gdx_kick:CheckPing")
AddEventHandler("gdx_kick:CheckPing", function()
	ping = GetPlayerPing(source)
	if ping >= Config.PingLimit then
		DropPlayer(source, _U('afk_ping', Config.PingLimit, ping))
	end
end)