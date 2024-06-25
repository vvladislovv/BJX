local function closeFunction()
	script.Parent.Parent.Parent.Parent["Developer Menu"]:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.6)
	script.Parent.Parent.Parent:TweenPosition(UDim2.new(0.5, 0, -2.5, 0), "Out", "Back", 0.6)
end

script.Parent.MouseButton1Click:Connect(closeFunction)