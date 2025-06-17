-- TweenHelper: Utility module to simplify common UI tweening actions
local TweenService = game:GetService("TweenService")
local TweenHelper = {}

-- Helper function to create and return a tween
local function CreateTween(instance, TweenInfo: TweenInfo, propertyTable)
	local tween = TweenService:Create(instance, TweenInfo, propertyTable)
	return tween
end

-- Smoothly toggles a UI frame open or closed
function TweenHelper.ToggleFrame(Frame: Frame, open: boolean)
	if not Frame then
		return
	end

	-- Try to find the parent ScreenGui
	local gui = Frame:FindFirstAncestorOfClass("ScreenGui")

	if not gui then
		warn("Frame has no parent ScreenGui")
		return
	end

	-- Store the original size if not already stored
	if not Frame:GetAttribute("OriginalSize") then
		Frame:SetAttribute("OriginalSize", Frame.Size)
	end
	local originalSize = Frame:GetAttribute("OriginalSize")

	local TWEEN_DURATION = 0.15

	if open then
		-- Prepare frame to appear with a scale animation
		gui.Enabled = true
		Frame.Size = UDim2.new(0, 0, 0, 0)

		local OpeningInfo = TweenInfo.new(TWEEN_DURATION)
		local OpeningTable = { Size = originalSize }

		local tween = CreateTween(Frame, OpeningInfo, OpeningTable)
		tween:Play()
	else
		-- Animate the frame closing down to 0, then disable it
		local ClosingInfo = TweenInfo.new(TWEEN_DURATION)
		local ClosingTable = { Size = UDim2.new(0, 0, 0, 0) }

		local tween = CreateTween(Frame, ClosingInfo, ClosingTable)
		tween:Play()

		tween.Completed:Connect(function()
			gui.Enabled = false
		end)
	end
end

-- Plays a quick "press" scale effect on a button
function TweenHelper.PressedTween(Button)
	if not Button:FindFirstChild("UIScale") then
		local UIScale = Instance.new("UIScale")
		UIScale.Parent = Button
	end

	local UIScale = Button:FindFirstChild("UIScale")
	local TWEEN_DURATION = 0.08

	local function Tweening(Scale)
		local tweenInfo: TweenInfo = TweenInfo.new(TWEEN_DURATION)
		local PropertyTable = { Scale = Scale }

		local tween = CreateTween(UIScale, tweenInfo, PropertyTable)
		tween:Play()
		tween.Completed:Wait()

		-- Reset scale to normal after animation
		PropertyTable = { Scale = 1 }
		local tween2 = CreateTween(UIScale, tweenInfo, PropertyTable)
		tween2:Play()
	end

	Tweening(0.95)
end

-- Adds hover animation to a button (slightly enlarges on mouse enter)
function TweenHelper.Hover(Button)
	if not (Button:IsA("TextButton") or Button:IsA("ImageButton")) then
		return
	end

	if not Button:FindFirstChild("UIScale") then
		local UIScale = Instance.new("UIScale")
		UIScale.Parent = Button
	end

	local UIScale = Button:FindFirstChild("UIScale")
	local TWEEN_DURATION = 0.1

	local function Tweening(Scale)
		local tweenInfo: TweenInfo = TweenInfo.new(TWEEN_DURATION)
		local PropertyTable = { Scale = Scale }

		local tween = CreateTween(UIScale, tweenInfo, PropertyTable)
		tween:Play()
	end

	Button.MouseEnter:Connect(function()
		Tweening(1.05)
	end)

	Button.MouseLeave:Connect(function()
		Tweening(1)
	end)
end

-- Automatically wires up a close button to close its frame with animation
function TweenHelper.SetupCloseButton(Frame: Frame)
	local closeButton = Frame:WaitForChild("Close")

	if not (closeButton:IsA("TextButton") or closeButton:IsA("ImageButton")) then
		return
	end

	closeButton.MouseButton1Click:Connect(function()
		TweenHelper.PressedTween(closeButton)
		TweenHelper.ToggleFrame(Frame, false)
	end)
end

-- return the module
return TweenHelper
