RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "Byl jsi afk příliš dlouho.")
end)


-- Ping Kick
pingLimit = 400

RegisterServerEvent("checkMyPingBro")
AddEventHandler("checkMyPingBro", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "Tvůj ping byl příliš vysoký na to, abys mohl pokračovat v erpení. (Limit: " .. pingLimit .. " Tvůj Ping: " .. ping .. ")")
	end
end)