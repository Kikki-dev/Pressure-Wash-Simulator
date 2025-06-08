local Players = game:GetService("Players")
local player = Players.LocalPlayer

repeat
	task.wait(1)
until player:GetAttribute("Loaded")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interface = {}

local UIFolder = ReplicatedStorage:WaitForChild("UI")
local GUIFolder = UIFolder:WaitForChild("GUI")

local InterfaceGui: ScreenGui = GUIFolder.Interface:WaitForChild("InterfaceGui")

function Interface.Init()
	local InterfaceCopy = InterfaceGui:Clone()
	InterfaceCopy.Enabled = true
	InterfaceCopy.Parent = player.PlayerGui
end

return Interface
