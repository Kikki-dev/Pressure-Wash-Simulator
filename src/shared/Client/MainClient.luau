local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainClient = {}

local clientFolder = ReplicatedStorage.Shared:WaitForChild("Client")

local Cleaner = require(clientFolder:WaitForChild("Gameplay").Cleaner)

function MainClient:Start()
	print("MainClient Started")
	Cleaner.Start()
end

return MainClient
