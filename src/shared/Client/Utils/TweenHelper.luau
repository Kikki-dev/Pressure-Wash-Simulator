local TweenService = game:GetService("TweenService")
local TweenHelper = {}

local function CreateTween(instance, TweenInfo: TweenInfo, propertyTable)
	local tween = TweenService:Create(instance, TweenInfo, propertyTable)
	return tween
end

function TweenHelper.ToggleFrame(Frame: Frame, open: boolean)
	if not Frame then
		return
	end

	local gui = Frame:FindFirstAncestorOfClass("ScreenGui")

	if not gui then
		warn("Frame has no parent ScreenGui")
		return
	end

	if not Frame:GetAttribute("OriginalSize") then
		Frame:SetAttribute("OriginalSize", Frame.Size)
	end
	local originalSize = Frame:GetAttribute("OriginalSize")

	if open then
		gui.Enabled = true
		Frame.Size = UDim2.new(0, 0, 0, 0)

		local TWEEN_DURATION = 0.2

		local OpeningInfo = TweenInfo.new(TWEEN_DURATION)
		local OpeningTable = { Size = originalSize }

		local tween = CreateTween(Frame, OpeningInfo, OpeningTable)
		tween:Play()
	else
		local TWEEN_DURATION = 0.2

		local ClosingInfo = TweenInfo.new(TWEEN_DURATION)
		local ClosingTable = { Size = UDim2.new(0, 0, 0, 0) }

		local tween = CreateTween(Frame, ClosingInfo, ClosingTable)
		tween:Play()

		tween.Completed:Connect(function()
			gui.Enabled = false
		end)
	end
end

function TweenHelper.PressedTween(Button)
	print(Button)
end

function TweenHelper.Hover(Button)
	if not (Button:IsA("TextButton") or Button:IsA("ImageButton")) then
		print("Close Button is not a Button")
		return
	end

	Button.MouseEnter:Connect(function()
		print("Button is hovered")
	end)
end

function TweenHelper.SetupCloseButton(Frame: Frame)
	local closeButton = Frame:WaitForChild("Close")

	if not (closeButton:IsA("TextButton") or closeButton:IsA("ImageButton")) then
		warn("Le bouton Close n'est pas valide.")
		return
	end

	closeButton.MouseButton1Click:Connect(function()
		TweenHelper.PressedTween(closeButton)
		TweenHelper.ToggleFrame(Frame, false)
	end)
end

return TweenHelper
