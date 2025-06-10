local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenHelper = require(ReplicatedStorage.Shared.Client.Utils.TweenHelper)
local Interface = {}

local UIFolder = ReplicatedStorage:WaitForChild("UI")
local GUIFolder = UIFolder:WaitForChild("GUI")

local InterfaceGui: ScreenGui = GUIFolder.Interface:WaitForChild("InterfaceGui")

local InventoryEvent: BindableEvent = ReplicatedStorage.Remotes:WaitForChild("Inventory")

function Interface.Init()
	local InterfaceCopy = InterfaceGui:Clone()
	InterfaceCopy.Enabled = true
	InterfaceCopy.Parent = player.PlayerGui

	local MainFrame = InterfaceCopy.Main

	local Inventory = MainFrame:WaitForChild("Inventory")
	Inventory.Open.MouseButton1Click:Connect(function()
		print("OpenInv pressed")
		TweenHelper.Hover(Inventory.Open)
		InventoryEvent:Fire()
	end)
end

return Interface
