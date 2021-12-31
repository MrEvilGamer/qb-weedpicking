local QBCore = exports['qb-core']:GetCoreObject()

local itemcraft = 'markedbills'

RegisterServerEvent('qb-weedpicking:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	    if 	TriggerClientEvent("QBCore:Notify", src, "Picked up some Cannabis!!", "Success", 1000) then
		  Player.Functions.AddItem('cannabis', 1) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "add")
	    end
end)

RegisterServerEvent('qb-weedpicking:processweed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cannabis = Player.Functions.GetItemByName("cannabis")
      local empty_weed_bag = Player.Functions.GetItemByName("empty_weed_bag")

    if cannabis ~= nil and empty_weed_bag ~= nil then
        if Player.Functions.RemoveItem('cannabis', 3) and Player.Functions.RemoveItem('empty_weed_bag', 1) then
            Player.Functions.AddItem('weed_bag', 1)-----change this
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove")
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weed_bag'], "add")
            TriggerClientEvent('QBCore:Notify', src, 'Cannabis Processed successfully', "success")  
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
    end
end)

--selldrug ok

RegisterServerEvent('qb-weedpicking:selld', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Item = Player.Functions.GetItemByName('weed_bag')
   
	if Item ~= nil and Item.amount >= 1 then
		local chance2 = math.random(1, 12)
		if chance2 == 1 or chance2 == 2 or chance2 == 9 or chance2 == 4 or chance2 == 10 or chance2 == 6 or chance2 == 7 or chance2 == 8 then
			Player.Functions.RemoveItem('weed_bag', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weed_bag'], "remove")
			Player.Functions.AddMoney("cash", Config.Pricesell, "sold-pawn-items")
			TriggerClientEvent('QBCore:Notify', src, 'you sold to the pusher', "success")  
		else
			Player.Functions.RemoveItem('weed_bag', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weed_bag'], "remove")
			Player.Functions.AddMoney("cash", Config.Pricesell-100, "sold-pawn-items")
			TriggerClientEvent('QBCore:Notify', src, 'you sold to the pusher', "success")
		end
else
	TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	
end
end)

function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('qb-weedpicking:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('QBCore_:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('qb-weedpicking:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

QBCore.Functions.CreateCallback('poppy:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "cannabis" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any Cannabis", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)
