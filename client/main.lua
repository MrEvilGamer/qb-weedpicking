isLoggedIn = true

local menuOpen = false
local wasOpen = false
local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp, isProcessing = false, false


RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    CheckCoords()
end)

function CheckCoords()
	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			-- print('Spawning Evil Weed Now')
			if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 2000 then
				SpawnWeedPlants()
			end
			Citizen.Wait(20 * 60000)
		end
	end)
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		CheckCoords()
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)

-- 		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessing.coords, true) < 1 then
-- 			DrawMarker(27, Config.CircleZones.WeedProcessing.coords.x, Config.CircleZones.WeedProcessing.coords.y, Config.CircleZones.WeedProcessing.coords.z - 0.66 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)

-- 			if not isProcessing then
-- 				QBCore.Functions.Draw2DText('Press ~g~[ E ]~w~ to Process Cannabis')
-- 			end

-- 			if IsControlJustReleased(0, 38) and not isProcessing then
-- 				TriggerServerEvent('qb-weedpicking:processCannabis')
-- 					if result then
-- 						ProcessWeed()
-- 					else
-- 						QBCore.Functions.Notify('You do not have enough Cannabis to process..', 'error')
-- 					end
-- 				end, 'cannabis')
-- 			end
-- 		else
-- 			Citizen.Wait(500)
-- 		end
-- 	end
-- end)

--marijuana to joint
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessing.coords, true) < 1 then
			DrawMarker(27, Config.CircleZones.WeedProcessing.coords.x, Config.CircleZones.WeedProcessing.coords.y, Config.CircleZones.WeedProcessing.coords.z - 0.66 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)

			if not isProcessing then
				--QBCore.Functions.Draw2DText('Press ~g~[ E ]~w~ to Process Cannabis')
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					if result then
						ProcessWeed()
					else
						QBCore.Functions.Notify('You dont have enough Marijuana', 'error')
					end
				end, 'marijuana')
			end
		else
			Citizen.Wait(500)
		end
	end
end)
 --cannabis to marijuana
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessingmarijuana.coords, true) < 1 then
			DrawMarker(27, Config.CircleZones.WeedProcessingmarijuana.coords.x, Config.CircleZones.WeedProcessingmarijuana.coords.y, Config.CircleZones.WeedProcessingmarijuana.coords.z - 0.66 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)

			if not isProcessing then
				--QBCore.Functions.Draw2DText('Press ~g~[ E ]~w~ to Process Cannabis')
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					if result then
						ProcessWeedmarijuana()
					else
						QBCore.Functions.Notify('You dont have enough Cannabis', 'error')
					end
				end, 'cannabis')
			end
		else
			Citizen.Wait(500)
		end
	end
end)


function ProcessWeed()  --joint process
	isProcessing = true
	local playerPed = PlayerPedId()

	--
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing..", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	 TriggerServerEvent('qb-weedpicking:processCannabis') -- Done

		local timeLeft = Config.Delays.WeedProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
				TriggerServerEvent('qb-weedpicking:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end) -- Cancel
		
	
	isProcessing = false
end

function ProcessWeedmarijuana() --marijuana process
	isProcessing = true
	local playerPed = PlayerPedId()

	--TriggerServerEvent('qb-weedpicking:processCannabisxD')
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing..", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	 TriggerServerEvent('qb-weedpicking:processCannabisxD') -- Done

		local timeLeft = Config.Delays.WeedProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
				TriggerServerEvent('qb-weedpicking:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end) -- Cancel
		
	
	isProcessing = false
end



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		
		
		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				QBCore.Functions.Draw2DText(0.5, 0.88, 'Press ~g~[E]~w~ to pickup Cannabis', 0.5)
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				QBCore.Functions.Progressbar("search_register", "Picking up Cannabis..", 7500, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.DeleteObject(nearbyObject)

					table.remove(weedPlants, nearbyID)
					spawnedWeeds = spawnedWeeds - 1

					TriggerServerEvent('qb-weedpicking:pickedUpCannabis')
				end, function()
					ClearPedTasks(PlayerPedId())
				end) -- Cancel

				isPickingUp = false
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			QBCore.Functions.DeleteObject(v)
		end
	end
end)

function SpawnWeedPlants()
	while spawnedWeeds < 25 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()

		QBCore.Functions.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			-- print('SpawnEvilWeedPlants()')

			table.insert(weedPlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end
