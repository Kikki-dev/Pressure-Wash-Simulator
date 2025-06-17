-- Saving system for dirty parts

local DataStoreService = game:GetService("DataStoreService")
local DirtStore = DataStoreService:GetDataStore("CleanedModels_v12")

local CleaningData = {}
local saveQueues = {}
local isSaving = {}

-- Setup everything : look for cleaned parts using the last function of this script to destroy decals from cleaned parts & setting the Attribute "IsDirty" to false.

function CleaningData.Init(player, DirtFolder)
	local cleanedModels = CleaningData:GetCleanedModels(player)

	for _, model in pairs(DirtFolder:GetChildren()) do
		if model:IsA("Model") and model:GetAttribute("DirtModelID") then
			local modelId = model:GetAttribute("DirtModelID")
			if cleanedModels[modelId] then
				for _, part in pairs(model:GetDescendants()) do
					if part:IsA("BasePart") then
						part:SetAttribute("IsDirty", false)
						local decal = part:FindFirstChildOfClass("Decal")
						if decal then
							decal:Destroy()
						end
					end
				end
			end
		end
	end
end

-- If the player cleans a part it's cleaned and saved in the dataSotore

function CleaningData:MarkClean(player, DirlModelID)
	local key = "Player_" .. player.UserId

	if not saveQueues[key] then
		saveQueues[key] = {}
	end
	saveQueues[key][DirlModelID] = true

	if isSaving[key] then
		return
	end

	isSaving[key] = true
	task.delay(5, function()
		local data = DirtStore:GetAsync(key) or {}

		for id in pairs(saveQueues[key]) do
			data[id] = true
		end

		local success, err = pcall(function()
			DirtStore:SetAsync(key, data)
		end)

		if not success then
			warn("[CleaningData] Failed to save dirt data:", err)
		end

		saveQueues[key] = nil
		isSaving[key] = false
	end)
end

-- Get the cleaned parts stored in the data store using a key
function CleaningData:GetCleanedModels(player)
	local key = "Player_" .. player.UserId
	local success, result = pcall(function()
		return DirtStore:GetAsync(key)
	end)
	if success then
		return result or {}
	else
		warn("[CleaningData] Failed to load data:", result)
		return {}
	end
end

return CleaningData
