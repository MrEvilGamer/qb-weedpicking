Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 3
}

Config.DrugDealerItems = {
	marijuana = 91
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

-- Config.LicensePrices = {
-- 	weed_processing = {label = _U('license_weed'), price = 10000}
-- }

Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = 'blip_weedfield', color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(1392.02, 3605.74, 38.68), name = 'blip_weedprocessing', color = 25, sprite = 496, radius = 100.0},
	WeedProcessingmarijuana = {coords = vector3(2328.92, 2571.35, 46.387), name = 'blip_weedprocessing', color = 25, sprite = 496, radius = 100.0},

	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = 'blip_drugdealer', color = 6, sprite = 378, radius = 25.0},
}