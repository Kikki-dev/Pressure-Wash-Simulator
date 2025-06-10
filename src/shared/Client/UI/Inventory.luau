local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenHelper = require(ReplicatedStorage.Shared.Client.Utils.TweenHelper)
local Inventory = {}

local GUIFolder = ReplicatedStorage.UI.GUI
local inventoryGui: ScreenGui = GUIFolder.Inventory.InventoryGui

local InventoryEvent: BindableEvent = ReplicatedStorage.Remotes:WaitForChild("Inventory")

function Inventory.Init()
	local inventoryGuiClone = inventoryGui:Clone()
	inventoryGuiClone.Parent = player.PlayerGui

	local MainFrame = inventoryGuiClone:WaitForChild("Main")

	TweenHelper.SetupCloseButton(inventoryGuiClone.Main)
	TweenHelper.ToggleFrame(MainFrame, true)
	TweenHelper.Hover(inventoryGuiClone.Main.Close)

	InventoryEvent.Event:Connect(function()
		TweenHelper.ToggleFrame(MainFrame, true)
	end)
end

return Inventory
