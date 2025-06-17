local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

repeat
	task.wait(1)
until player:GetAttribute("Loaded")

local MainClient = {}

local clientFolder = ReplicatedStorage.Shared:WaitForChild("Client")

local Interface = require(ReplicatedStorage.Shared.Client.UI.Interface)
local Inventory = require(ReplicatedStorage.Shared.Client.UI.Inventory)
local Cleaner = require(clientFolder:WaitForChild("Gameplay").Cleaner)

-- Setup every Client modules we need : Cleaner, Interface & Inventory

function MainClient:Start()
	print("MainClient Started")
	Cleaner.Start()
	Interface.Init()
	Inventory.Init()
end

-- Return the module so the Client script can acces it

return MainClient
