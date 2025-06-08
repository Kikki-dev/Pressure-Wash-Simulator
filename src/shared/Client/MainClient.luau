local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainClient = {}

local clientFolder = ReplicatedStorage.Shared:WaitForChild("Client")

local Interface = require(ReplicatedStorage.Shared.Client.UI.Interface)
local Cleaner = require(clientFolder:WaitForChild("Gameplay").Cleaner)

function MainClient:Start()
	print("MainClient Started")
	Cleaner.Start()
	Interface.Init()
end

return MainClient
