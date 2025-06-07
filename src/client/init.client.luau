local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainClient = require(ReplicatedStorage.Shared.Client.MainClient)

print("Starting MainClient")
MainClient:Start()
