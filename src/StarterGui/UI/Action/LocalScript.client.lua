local Info = script.Parent
local TS = game:GetService("TweenService")

Info.MouseEnter:Connect(function()
	TS:Create(Info.UIGradient, TweenInfo.new(0.4), {Rotation = 25}):Play()
	Info:TweenSize(UDim2.new(0, 300*1.2, 0, 60*1.2), "Out", "Back", 0.3, true)
end)
Info.MouseMoved:Connect(function()
	Info:TweenSize(UDim2.new(0, 300*1.2, 0, 60*1.2), "Out", "Back", 0.3, true)
end)
Info.MouseLeave:Connect(function()
	TS:Create(Info, TweenInfo.new(0.4), {Rotation = 0}):Play()
	TS:Create(Info.UIGradient, TweenInfo.new(0.4), {Rotation = -30}):Play()
	Info:TweenSize(UDim2.new(0, 300, 0, 60), "Out", "Back", 0.3, true)
end)

Info.MouseButton1Down:Connect(function()
	TS:Create(Info, TweenInfo.new(0.4), {Rotation = -3}):Play()
	Info:TweenSize(UDim2.new(0, 300*0.85, 0, 60*0.85), "Out", "Back", 0.3, true)
end)
Info.MouseButton1Up:Connect(function()
	TS:Create(Info, TweenInfo.new(0.4), {Rotation = 0}):Play()
	Info:TweenSize(UDim2.new(0, 300*1.2, 0, 60*1.2), "Out", "Back", 0.3, true)
end)