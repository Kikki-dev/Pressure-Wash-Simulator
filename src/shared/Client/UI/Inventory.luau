-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local TweenHelper = require(ReplicatedStorage.Shared.Client.Utils.TweenHelper)

-- Inventory module table
local Inventory = {}

-- Reference to the GUI stored in ReplicatedStorage
local GUIFolder = ReplicatedStorage.UI.GUI
local inventoryGui: ScreenGui = GUIFolder.Inventory.InventoryGui

-- Event used to trigger the inventory opening
local InventoryEvent: BindableEvent = ReplicatedStorage.Remotes:WaitForChild("Inventory")

-- Initializes the inventory UI for the local player
function Inventory.Init()
	-- Clone the inventory GUI and parent it to the player's PlayerGui
	local inventoryGuiClone = inventoryGui:Clone()
	inventoryGuiClone.Parent = player.PlayerGui

	-- Get the main frame inside the GUI
	local MainFrame = inventoryGuiClone:WaitForChild("Main")

	-- Set up the close button logic and UI effects using helper module
	TweenHelper.SetupCloseButton(inventoryGuiClone.Main)

	-- Show the main inventory frame with animation
	TweenHelper.ToggleFrame(MainFrame, true)

	-- Add hover effect to the close button (optional visual feedback)
	TweenHelper.Hover(inventoryGuiClone.Main.Close)

	-- Reopen inventory when the event is triggered (e.g. from another script)
	InventoryEvent.Event:Connect(function()
		TweenHelper.ToggleFrame(MainFrame, true)
	end)
end

-- Return the module so it can be required from other scripts
return Inventory
