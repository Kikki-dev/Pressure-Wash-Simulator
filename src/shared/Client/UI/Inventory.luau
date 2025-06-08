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
	inventoryGuiClone.Enabled = true -- retirer cette ligne quand l'inv sera codé

	TweenHelper.CloseFrame(inventoryGuiClone.Main)
	TweenHelper.Hover(inventoryGuiClone.Main.Close)
end

return Inventory
