local TS = game:GetService("TweenService")

for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("TextButton") then
		v.MouseEnter:Connect(function()
			TS:Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(176, 231, 211)}):Play()
		end)
		v.MouseLeave:Connect(function()
			TS:Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(230,230,230)}):Play()
		end)
	end
end