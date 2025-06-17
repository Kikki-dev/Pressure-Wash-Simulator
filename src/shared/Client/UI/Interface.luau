-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local TweenHelper = require(ReplicatedStorage.Shared.Client.Utils.TweenHelper)

-- Module table
local Interface = {}

-- Get GUI references from ReplicatedStorage
local UIFolder = ReplicatedStorage:WaitForChild("UI")
local GUIFolder = UIFolder:WaitForChild("GUI")

-- Main interface GUI
local InterfaceGui: ScreenGui = GUIFolder.Interface:WaitForChild("InterfaceGui")

-- Event to trigger inventory opening
local InventoryEvent: BindableEvent = ReplicatedStorage.Remotes:WaitForChild("Inventory")

-- Initializes the interface for the player
function Interface.Init()
	-- Clone the interface GUI and add it to the player's PlayerGui
	local InterfaceCopy = InterfaceGui:Clone()
	InterfaceCopy.Enabled = true
	InterfaceCopy.Parent = player.PlayerGui

	-- Get the main container frame and inventory button
	local MainFrame = InterfaceCopy.Main
	local Inventory = MainFrame:WaitForChild("Inventory")

	-- Add a hover effect to the inventory open button
	TweenHelper.Hover(Inventory.Open)

	-- Connect the click event to open the inventory and play a button animation
	Inventory.Open.MouseButton1Click:Connect(function()
		-- Fire the inventory open event (handled elsewhere)
		InventoryEvent:Fire()
		-- Play pressed button animation
		TweenHelper.PressedTween(Inventory.Open)
	end)
end

-- Return the module
return Interface
