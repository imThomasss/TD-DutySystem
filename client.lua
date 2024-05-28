---------------------------Blip stuff---------------------------------
local ACTIVE = false

local currentBlips = {}

------------
-- events --
------------
RegisterNetEvent("eblips:toggle")
AddEventHandler("eblips:toggle", function(on)
	-- toggle blip display --
	ACTIVE = on
	-- remove all blips if turned off --
	if not ACTIVE then
		RemoveAnyExistingEmergencyBlips()
	end
end)

RegisterNetEvent("eblips:updateAll")
AddEventHandler("eblips:updateAll", function(activeEmergencyPersonnel)
	if ACTIVE then
		RemoveAnyExistingEmergencyBlips()
		RefreshBlips(activeEmergencyPersonnel)
	end
end)

---------------
-- functions --
---------------
function RemoveAnyExistingEmergencyBlips()
	for i = #currentBlips, 1, -1 do
		local b = currentBlips[i]
		if b ~= 0 then
			RemoveBlip(b)
			table.remove(currentBlips, i)
		end
	end
end

function RefreshBlips(activeEmergencyPersonnel)
	local myServerId = GetPlayerServerId(PlayerId())
	for src, info in pairs(activeEmergencyPersonnel) do
		if src ~= myServerId then
			if info and info.coords then
				local blip = AddBlipForCoord(info.coords.x, info.coords.y, info.coords.z)
				SetBlipSprite(blip, 1)
				SetBlipColour(blip, info.color)
				SetBlipAsShortRange(blip, true)
				SetBlipDisplay(blip, 4)
				SetBlipShowCone(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(info.name)
				EndTextCommandSetBlipName(blip)
				table.insert(currentBlips, blip)
      
			end
		end
	end
  Citizen.Wait(0)
end



--[[
    On duty Event
]]
currentJob = "not set"
onduty = false

RegisterNetEvent("TD:OnDuty:LSPD")
AddEventHandler("TD:OnDuty:LSPD", function()
  local job = TDGetCurrentJob()
  if job == "not set" or job == "LSPD" then
      local noti = nil
      LSPDonduty = not LSPDonduty
      if LSPDonduty then
      currentJob = "LSPD"
        noti = " Your job is now LSPD"
        onduty = true
        ids = GetPlayerServerId(PlayerId())
        TriggerServerEvent("eblips:add", {name = "LSPD", src = ids, color = 2})
        inServiceCops = true
        
      else
        noti = " You are no longer on duty."
        currentJob = "not set"
        onduty = false
        inServiceCops = false
      end
      lib.notify({
          id = 'idkijustworkherelol',
          title = Config.ServerName,
          description = noti,
          showDuration = true,
          position = 'top-right',
          style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'circle-info',
          iconAnimation = "beat",
          iconColor = '#ADD8E6'
      })
    else
      lib.notify({
        id = 'jobadghadsfsdghdf',
        title = Config.ServerName,
        description = 'Your Job is currently set to ' .. job .. '. Please make sure you have cleared your job and try again!',
        showDuration = true,
        duration = 8000,
        position = 'top-right',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'circle-exclamation',
        iconAnimation = "beat",
        iconColor = '#FF0000'
    })
    end

  end)


RegisterNetEvent("TD:OnDuty:Sheriff")
AddEventHandler("TD:OnDuty:Sheriff", function()
  local job = TDGetCurrentJob()
  if job == "not set" or job == "BCSO" then
      local noti = nil
      Sheriffonduty = not Sheriffonduty
      if Sheriffonduty then
      currentJob = "BCSO"
        noti = " Your job is now BCSO"
        onduty = true
        ids = GetPlayerServerId(PlayerId())
        TriggerServerEvent("eblips:add", {name = "BCSO", src = ids, color = 17}) -- can be used with blips https://forum.fivem.net/t/release-emergencyblips/493022
        inServiceCops = true
      else
        noti = " You are no longer on duty."
        currentJob = "not set"
        onduty = false
        inServiceCops = false
        TriggerServerEvent("eblips:remove", ids)
      end
      lib.notify({
          id = 'idkijustworkherelol',
          title = Config.ServerName,
          description = noti,
          showDuration = true,
          position = 'top-right',
          style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'circle-info',
          iconAnimation = "beat",
          iconColor = '#ADD8E6'
      })
  else
    lib.notify({
      id = 'jobnotisheriff',
      title = Config.ServerName,
      description = 'Your Job is currently set to ' .. job .. '. Please make sure you have cleared your job and try again!',
      showDuration = true,
      duration = 8000,
      position = 'top-right',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'circle-exclamation',
      iconAnimation = "beat",
      iconColor = '#FF0000'
  })
  end

end)


RegisterNetEvent("TD:OnDuty:SAHP")
AddEventHandler("TD:OnDuty:SAHP", function()
  local job = TDGetCurrentJob()
  if job == "not set" or job == "SAHP" then
      local noti = nil
      SAHPonduty = not SAHPonduty
      if SAHPonduty then
      currentJob = "SAHP"
        noti = " Your job is now SAHP"
        onduty = true
        ids = GetPlayerServerId(PlayerId())
        TriggerServerEvent("eblips:add", {name = "SAHP", src = ids, color = 38})
        inServiceCops = true
      else
        noti = " You are no longer on duty."
        currentJob = "not set"
        onduty = false
        inServiceCops = false
      end
      lib.notify({
          id = 'idkijustworkherelol',
          title = Config.ServerName,
          description = noti,
          showDuration = true,
          position = 'top-right',
          style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'circle-info',
          iconAnimation = "beat",
          iconColor = '#ADD8E6'
      })
  else
    lib.notify({
      id = 'jobnotisahp',
      title = Config.ServerName,
      description = 'Your Job is currently set to ' .. job .. '. Please make sure you have cleared your job and try again!',
      showDuration = true,
      duration = 8000,
      position = 'top-right',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'circle-exclamation',
      iconAnimation = "beat",
      iconColor = '#FF0000'
  })
  end

end)



RegisterNetEvent("TD:OnDuty:SAFR")
AddEventHandler("TD:OnDuty:SAFR", function()
  local job = TDGetCurrentJob()
  if job == "not set" or job == "SAFR" then
      local noti = nil
      SAFRonduty = not SAFRonduty
      if SAFRonduty then
      currentJob = "SAFR"
        noti = " Your job is now SAFR"
        onduty = true
        ids = GetPlayerServerId(PlayerId())
        TriggerServerEvent("eblips:add", {name = "SAFR", src = ids, color = 1}) -- can be used with blips https://forum.fivem.net/t/release-emergencyblips/493022
        inServiceCops = true
      else
        noti = " You are no longer on duty."
        currentJob = "not set"
        onduty = false
        inServiceCops = false
        TriggerServerEvent("eblips:remove", ids)
      end
      lib.notify({
          id = 'idkijustworkherelol',
          title = Config.ServerName,
          description = noti,
          showDuration = true,
          position = 'top-right',
          style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'circle-info',
          iconAnimation = "beat",
          iconColor = '#ADD8E6'
      })
  else
    lib.notify({
      id = 'jobnotisheriff',
      title = Config.ServerName,
      description = 'Your Job is currently set to ' .. job .. '. Please make sure you have cleared your job and try again!',
      showDuration = true,
      duration = 8000,
      position = 'top-right',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'circle-exclamation',
      iconAnimation = "beat",
      iconColor = '#FF0000'
  })
  end

end)






--[[
    911 Section
]]


RegisterNetEvent("TD:Submit911:Call")
AddEventHandler("TD:Submit911:Call", function()
    local input = lib.inputDialog("911", {
      {
        type = 'select',
        label = 'Service Required',
        description = 'Please select the service you require.',
        required = true,
        icon = 'fa-tower-broadcast',
        options = {
            { value = 'LEO', text = 'LEO' },
            { value = 'Fire & Rescue', text = 'Fire & Rescue' },
            { value = 'EMS', text = 'EMS' }
        },
        --default = 'leo' -- optional, sets the default selected value
        },
        { type = 'input',        label = 'Your Name',  description = 'Write your name here',               required = true, icon = 'fa-user' },
        { type = 'input',        label = 'Suspect(s) Name(s)',  description = 'Write suspect(s) name here if applicable',                required = false, icon = 'fa-handcuffs' },
        { type = 'input',        label = 'Suspect(s) Vehicle Number Plate(s) / Description',  description = 'Write vehicle number plate / description here if applicable',     required = false, icon = 'fas fa-car' },
        { type = 'input',        label = 'What happened?', description = 'Write the summary of what happened here!',        required = true, icon = 'fa-file-signature' },
        { type = 'input',        label = 'Nearest Postal',  description = 'Write the nearest postal here, we already have your full location!',     required = true, icon = 'fa-location-dot' },
    })
    if input then
        lib.progressCircle({
            duration = 5000,
            label = "Dispatching Law Enforcement...",
            useWhileDead = false,
            position = "bottom",
            canCancel = false,
        })
        --TriggerEvent("911:Receive:Call", input[1], input[2], input[3], input[4], input[5], streetName)
        local playerPos = GetEntityCoords(PlayerPedId())
        local testname = GetPlayerServerId(source)
        TriggerServerEvent("TD:Send911toOnDuty", source, input[1], input[2], input[3], input[4], input[5], input[6], playerPos, testname)
        lib.notify({
          id = '911callsuccesssent',
          title = Config.ServerName,
          description = 'Successfully Called Emergency Services',
          duration = 6000,
          showDuration = true,
          position = 'top-right',
          style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'phone',
          iconAnimation = "beat",
          iconColor = '#00ffb5'
      })
      end
      
end)


local callactive = false
RegisterNetEvent("911:Receive:Call")
AddEventHandler("911:Receive:Call", function(dname, cname, sname, sveh, desc, postal, playerPos)
    if onduty then
        local streetcoord = GetStreetNameAtCoord(playerPos.x, playerPos.y, playerPos.z)
        local streetName = GetStreetNameFromHashKey(streetcoord)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
          lib.showTextUI(
            ('New 911 Call Received: %s  \n'):format(" ") ..
            '[LEO/Fire/EMS]: ' .. dname .. '   \n' ..
            '[Description]: ' .. desc .. '   \n' ..
            '[Location]: ' ..streetName.. '  \n' ..
            '[Callers Name]: ' .. cname .. '  \n' ..
            '[Suspect Name]: ' ..sname .. '  \n' ..
            '[Suspect Vehicle]: ' ..sveh .. '  \n' ..
            '[Postal]: ' .. postal .. '  \n' ..
            '[Y]  - Close   |   [E] - Draw waypoint  \n', {
            position = "left-center",
            icon = 'phone',
            iconAnimation = "beat",
            iconColor = "#00ffb5",
            uiShowing = true,
            style = {
                borderRadius = 5,
                backgroundColor = '#141517',
                color = 'white'
            }
          })
          callactive = true
      while true do
        Wait(0)
        if callactive then
            if IsControlJustReleased (0, 246) then
              Wait(100)
              print("close")
              lib.hideTextUI()
              Wait(1000)
              callactive = false
            end
            if IsControlJustPressed(0, 51) then
              lib.notify({
                id = 'idkijustworkhere',
                title = Config.ServerName,
                description = 'Drawing route to the call',
                showDuration = true,
                position = 'top-right',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                      color = '#909296'
                    }
                },
                icon = 'arrows-rotate',
                iconAnimation = "spin",
                iconColor = '#00ffb5'
            })
              Wait(3000)
              SetNewWaypoint(playerPos)
              lib.notify({
                id = 'istilldk',
                title = Config.ServerName,
                description = 'Route has been drawn.',
                showDuration = true,
                position = 'top-right',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                      color = '#909296'
                    }
                },
                icon = 'check',
                iconAnimation = "beat",
                iconColor = '#00ffb5'
            })
            Wait(1000)
            if Config.Hide911WhenAccepted then
              lib.hideTextUI()
            end

            end
          end
      end
    end
end)




