-- RemotesHandler: Handles remote events received from clients
local RemotesHandler = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Module dependencies
local MainServer = script.Parent.Parent
local RewardService = require(ReplicatedStorage.Shared.Server.Gameplay.RewardService)
local CleaningData = require(MainServer.Data.CleaningData)

-- Initializes server-side remote listeners
function RemotesHandler.Init()
	-- Listens to a client event to reward cleaning money
	Remotes.GetCleaningMoney.OnServerEvent:Connect(function(player, amount, part)
		-- Add money to the player's balance
		RewardService.Add(player, "Money", amount)

		-- Try to locate the parent model for the cleaned part
		local model = part:FindFirstAncestorWhichIsA("Model")
		if model and model:GetAttribute("DirtModelID") then
			-- Mark part as no longer dirty
			part:SetAttribute("IsDirty", false)

			-- Mark the associated dirt model as cleaned
			CleaningData:MarkClean(player, model:GetAttribute("DirtModelID"))
		end
	end)
end

return RemotesHandler
