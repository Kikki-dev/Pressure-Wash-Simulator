local DataService = {}

local DataStoreService = game:GetService("DataStoreService")

local GlobalDataStore = DataStoreService:GetDataStore("GlobalData")

local defaultData = {
	Money = 0,
	Level = 1,
}

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

function DataService.SetUp(player)
	local key = "Player_" .. player.UserId
	local success, data = pcall(function()
		return GlobalDataStore:GetAsync(key)
	end)

	if not success then
		warn("[DataService] Failed to load data for " .. player.Name)
		data = {}
	end

	data = data or {}
	for stat, default in pairs(defaultData) do
		if data[stat] == nil then
			data[stat] = default
		end
	end

	createLeaderstats(player, data)
end

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

	local success, err = pcall(function()
		GlobalDataStore:SetAsync(key, dataToSave)
	end)

	if not success then
		warn("[DataService] Failed to save data for " .. player.Name .. ": " .. err)
	end
end

return DataService
