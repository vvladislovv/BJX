local Info = script.Parent
local TS = game:GetService("TweenService")

script.Parent.Parent.Fade.Close.MouseButton1Click:Connect(function()
	game.Lighting.Blur.Enabled = false
	script.Parent.Parent.SendBJP:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.25, true)
	script.Parent.Parent.Fade.Visible = false
	spawn(function()
		wait(0.25)
		script.Parent.Parent.SendBJP.Visible = false
	end)
end)

Info.MouseEnter:Connect(function()
	Info:TweenSize(UDim2.new(0, 65, 0, 65), "Out", "Back", 0.25, true)
end)
Info.MouseLeave:Connect(function()
	Info:TweenSize(UDim2.new(0, 55, 0, 55), "Out", "Back", 0.25, true)
end)

Info.MouseButton1Down:Connect(function()
	Info:TweenSize(UDim2.new(0, 45, 0, 45), "Out", "Back", 0.25, true)
end)

Info.MouseButton1Up:Connect(function()
	game.Lighting.Blur.Enabled = true
	Info:TweenSize(UDim2.new(0, 55, 0, 55), "Out", "Back", 0.25, true)
	script.Parent.Parent.Fade.Visible = true
	script.Parent.Parent.SendBJP.Visible = true
	script.Parent.Parent.SendBJP:TweenSize(UDim2.new(0, 274, 0, 253), "Out", "Back", 0.25, true)
end)