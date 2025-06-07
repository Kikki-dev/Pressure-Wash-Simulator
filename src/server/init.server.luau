local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainServer = require(ReplicatedStorage.Shared.Server.MainServer)

Players.PlayerAdded:Connect(function(player)
	print("Starting MainServer")

	MainServer:Start(player)
end)

Players.PlayerRemoving:Connect(function(player)
	print("Closing MainServer")
	MainServer:Close(player)
end)
