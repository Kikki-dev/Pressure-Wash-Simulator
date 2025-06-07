local RemotesHandler = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local MainServer = script.Parent.Parent
local RewardService = require(ReplicatedStorage.Shared.Server.Gameplay.RewardService)
local CleaningData = require(MainServer.Data.CleaningData)

function RemotesHandler.Init()
	Remotes.GetCleaningMoney.OnServerEvent:Connect(function(player, amount, part)
		RewardService.Add(player, "Money", amount)

		local model = part:FindFirstAncestorWhichIsA("Model")
		if model and model:GetAttribute("DirtModelID") then
			part:SetAttribute("IsDirty", false)
			CleaningData:MarkClean(player, model:GetAttribute("DirtModelID"))
		end
	end)
end

return RemotesHandler
