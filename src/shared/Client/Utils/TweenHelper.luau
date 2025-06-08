local TweenHelper = {}

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

function TweenHelper.CloseFrame(Frame: Frame)
	local closeButton = Frame:WaitForChild("Close")

	if not (closeButton:IsA("TextButton") or closeButton:IsA("ImageButton")) then
		print("Close Button is not a Button")
		return
	end

	closeButton.MouseButton1Click:Connect(function()
		TweenHelper.PressedTween(closeButton)
	end)
end

return TweenHelper
