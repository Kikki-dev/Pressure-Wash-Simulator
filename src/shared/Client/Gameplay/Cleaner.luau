local CleaningController = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local ClientFolder = ReplicatedStorage.Shared:WaitForChild("Client")

local UtilsFolder = ClientFolder:WaitForChild("Utils")
local Cleaners = require(ReplicatedStorage.Shared.Server.Gameplay.Cleaners)
local HitboxManager = require(UtilsFolder.HitboxManager)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local isCleaning = false
local cleaningLoopRunning = false
local raycastDistance = 20

local function Clean()
	if not player.Character:FindFirstChildOfClass("Tool") then
		return
	end

	local Tool = player.Character:FindFirstChildOfClass("Tool")
	local MoneyPerClick = Tool:GetAttribute("Money")

	local target = mouse.Target

	local mousePos = mouse.Hit.Position
	local range = Tool:GetAttribute("Range")
	local shape = "Sphere"
	local filterFolder = target.Parent

	local parts = HitboxManager:GetDirtyPartsInArea(shape, mousePos, range, filterFolder)

	for _, part in pairs(parts) do
		local distance = (part.Position - player.Character.HumanoidRootPart.Position).Magnitude
		if distance <= raycastDistance then
			local decal = part:FindFirstChildOfClass("Decal")
			if decal then
				decal:Destroy()
			end
			part:SetAttribute("IsDirty", false)
			Remotes.GetCleaningMoney:FireServer(MoneyPerClick, target)
		end
	end
end

function CleaningController.Start()
	print("[CleaningController] Started.")

	for name, data in pairs(Cleaners) do
		print(name .. ": Range=" .. data.Range)
	end

	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not isCleaning then
				isCleaning = true

				if not cleaningLoopRunning then
					cleaningLoopRunning = true
					task.spawn(function()
						while isCleaning do
							Clean()
							task.wait(0.1)
						end
						cleaningLoopRunning = false
					end)
				end
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isCleaning = false
		end
	end)
end

return CleaningController
