-- DataService: Handles saving and loading player data using Roblox DataStore
local DataService = {}

-- Services
local DataStoreService = game:GetService("DataStoreService")

-- Define the main DataStore
local GlobalDataStore = DataStoreService:GetDataStore("GlobalData")

-- Default values for new players
local defaultData = {
	Money = 0,
	Level = 1,
}

-- Creates leaderstats folder and fills it with values
local function createLeaderstats(player, data)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	for key, default in pairs(defaultData) do
		local val = Instance.new("NumberValue")
		val.Name = key
		val.Value = data[key] or default
		val.Parent = leaderstats
	end
end

-- Called when a player joins the game
function DataService.SetUp(player)
	local key = "Player_" .. player.UserId

	-- Try to load data from DataStore
	local success, data = pcall(function()
		return GlobalDataStore:GetAsync(key)
	end)

	if not success then
		warn("[DataService] Failed to load data for " .. player.Name)
		data = {}
	end

	-- Fallback to default values if needed
	data = data or {}
	for stat, default in pairs(defaultData) do
		if data[stat] == nil then
			data[stat] = default
		end
	end

	createLeaderstats(player, data)
end

-- Called when a player leaves the game
function DataService.Save(player)
	local key = "Player_" .. player.UserId
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		return
	end

	local dataToSave = {}
	for statName, _ in pairs(defaultData) do
		local stat = leaderstats:FindFirstChild(statName)
		if stat then
			dataToSave[statName] = stat.Value
		end
	end

	-- Try to save the data
	local success, err = pcall(function()
		GlobalDataStore:SetAsync(key, dataToSave)
	end)

	if not success then
		warn("[DataService] Failed to save data for " .. player.Name .. ": " .. err)
	end
end

return DataService
