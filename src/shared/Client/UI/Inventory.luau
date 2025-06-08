local Players = game:GetService("Players")
local player = Players.LocalPlayer

repeat
	task.wait(1)
until player:GetAttribute("Loaded")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Inventory = {}

local GUIFolder = ReplicatedStorage.UI.GUI
local inventoryGui: ScreenGui = GUIFolder.Inventory.inventoryGui

function Inventory.Init()
	inventoryGui.Enabled = true
end

return Inventory
