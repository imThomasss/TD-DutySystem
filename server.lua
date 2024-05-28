--[[
    Job Commands
]]

RegisterCommand("bcso", function(source)

    if Config.UseAcePerms then
        if IsPlayerAceAllowed(source, "Thomas.OnDuty.BCSO") then
            TriggerClientEvent("TD:OnDuty:Sheriff", source)
        else
            TriggerClientEvent('ox_lib:notify', source, {
                id = "bcsoerror1",
                title = Config.ServerName,
                description = "You do not have the required permissions for this!",
                duration = 5000,
                position = "top-right",
                type = "error",
                icon = "circle-exclamation",
                iconColor = "#FF0000",
            })
        end
    else
        TriggerClientEvent("TD:OnDuty:Sheriff", source)
    end
end)

RegisterCommand("lspd", function(source)
    if Config.UseAcePerms then
        if IsPlayerAceAllowed(source, "Thomas.OnDuty.LSPD") then
            TriggerClientEvent("TD:OnDuty:LSPD", source)
        else
            TriggerClientEvent('ox_lib:notify', source, {
                id = "lspderror1",
                title = Config.ServerName,
                description = "You do not have the required permissions for this!",
                duration = 5000,
                position = "top-right",
                type = "error",
                icon = "circle-exclamation",
                iconColor = "#FF0000",
            })
        end
    else
        TriggerClientEvent("TD:OnDuty:LSPD", source)
    end
end)

RegisterCommand("sahp", function(source)
    if Config.UseAcePerms then
        if IsPlayerAceAllowed(source, "Thomas.OnDuty.SAHP") then
            TriggerClientEvent("TD:OnDuty:SAHP", source)
        else
            TriggerClientEvent('ox_lib:notify', source, {
                id = "sahperror1",
                title = Config.ServerName,
                description = "You do not have the required permissions for this!",
                duration = 5000,
                position = "top-right",
                type = "error",
                icon = "circle-exclamation",
                iconColor = "#FF0000",
            })
        end
    else
        TriggerClientEvent("TD:OnDuty:SAHP", source)
    end
end)


RegisterCommand("safr", function(source)
    if Config.UseAcePerms then
        if IsPlayerAceAllowed(source, "Thomas.OnDuty.SAFR") then
            TriggerClientEvent("TD:OnDuty:SAFR", source)
        else
            TriggerClientEvent('ox_lib:notify', source, {
                id = "safrerror1",
                title = Config.ServerName,
                description = "You do not have the required permissions for this!",
                duration = 5000,
                position = "top-right",
                type = "error",
                icon = "circle-exclamation",
                iconColor = "#FF0000",
            })
        end
    else
        TriggerClientEvent("TD:OnDuty:SAFR", source)
    end
end)


--[[
    911
]]

RegisterCommand("911", function(source)
    TriggerClientEvent("TD:Submit911:Call", source)
end)


RegisterNetEvent("TD:Send911toOnDuty")
AddEventHandler("TD:Send911toOnDuty", function(source, dname, cname, sname, sveh, desc, postal, playerPos )
    TriggerClientEvent("911:Receive:Call", -1, dname, cname, sname, sveh, desc, postal, playerPos )
    log911message = (
        "**Service Required:** " .. dname ..
        "\n" ..
        "**Caller Name:** " .. cname ..
        "\n" ..
        "**Suspect Name:** " .. sname ..
        "\n" ..
        "**Suspect Vehicle** " .. sveh ..
        "\n" ..
        "**Call Description:** " .. desc ..
        "\n" ..
        "**Postal:** " .. postal ..
        "\n" ..
        "**Location:** " .. playerPos
        )
        Log911(log911message)
end)




--- Blips ---
-----------------------Blip stuff
local ACTIVE_EMERGENCY_PERSONNEL = {}

local CLIENT_UPDATE_INTERVAL_SECONDS = 3

--[[
person = {
 src = 123,
 color = 3,
 name = "Taylor Weitman"
}
]]

RegisterServerEvent("eblips:add")
AddEventHandler("eblips:add", function(person)
	ACTIVE_EMERGENCY_PERSONNEL[person.src] = person
	TriggerClientEvent("eblips:toggle", person.src, true)
end)

RegisterServerEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
	-- remove from list --
	ACTIVE_EMERGENCY_PERSONNEL[src] = nil
	-- deactive blips when off duty --
	TriggerClientEvent("eblips:toggle", src, false)
end)

-- Clean up blip entry for on duty player who leaves --
AddEventHandler("playerDropped", function()
	if ACTIVE_EMERGENCY_PERSONNEL[source] then
		ACTIVE_EMERGENCY_PERSONNEL[source] = nil
	end
end)

Citizen.CreateThread(function()
	local lastUpdateTime = os.time()
	while true do
		if os.difftime(os.time(), lastUpdateTime) >= CLIENT_UPDATE_INTERVAL_SECONDS then
			for id, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
				ACTIVE_EMERGENCY_PERSONNEL[id].coords = GetEntityCoords(GetPlayerPed(id))
				TriggerClientEvent("eblips:updateAll", id, ACTIVE_EMERGENCY_PERSONNEL)
			end
			lastUpdateTime = os.time()
		end
		Citizen.Wait(0)  --was Wait(500)
	end
end)



---- Webhook



function Log911(log911message)
    if Config.DiscordLog911 then
        local connect = {
            {
                ["color"] = 65280,
                ["title"] = "**[Thomas Developments] A new 911 Call has been received**",
                ["description"] = log911message,
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                ["footer"] = {
                    ["text"] = "[TD-DutySystem]",
                },
            }
        }
        PerformHttpRequest(Config.Webhook911Call, function(err, text, headers) end, 'POST', json.encode({embeds = connect}), { ['Content-Type'] = 'application/json' })
    end
end