local Players = game:GetService("Players")
local player = Players.LocalPlayer

repeat
	task.wait(1)
until player:GetAttribute("Loaded")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenHelper = require(ReplicatedStorage.Shared.Client.Utils.TweenHelper)
local Inventory = {}

local GUIFolder = ReplicatedStorage.UI.GUI
local inventoryGui: ScreenGui = GUIFolder.Inventory.InventoryGui

function Inventory.Init()
	local inventoryGuiClone = inventoryGui:Clone()
	inventoryGuiClone.Parent = player.PlayerGui

	local MainFrame = inventoryGuiClone:WaitForChild("Main")

	TweenHelper.SetupCloseButton(inventoryGuiClone.Main)
	TweenHelper.ToggleFrame(MainFrame, true)
	TweenHelper.Hover(inventoryGuiClone.Main.Close)
end

return Inventory
