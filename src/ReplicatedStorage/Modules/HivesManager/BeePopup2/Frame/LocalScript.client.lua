local ts = game:GetService("TweenService")
local pop = script.Parent.Parent
local fra = script.Parent

script.Parent.MouseButton1Down:Connect(function()
	pop:TweenSize(UDim2.new(0,480*1.15,0,250*1.15), "Out", "Back", 0.5, true)
end)

script.Parent.MouseButton1Up:Connect(function()
	pop:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.8, true)
	ts:Create(pop, TweenInfo.new(0.33), {Rotation = 359}):Play()
	ts:Create(fra, TweenInfo.new(0.22), {Rotation = -359}):Play()
	wait(0.1)
	pop:TweenPosition(UDim2.new(1.25,0,0.25,0), "Out", "Back", 0.8, true)
	spawn(function()
		wait(0.8)
		pop:Destroy()
	end)
end)
local deb = 1
while true do
	ts:Create(fra.Icon.Bee, TweenInfo.new(0.4), {Rotation = 5}):Play()
	wait(0.4)
	ts:Create(fra.Icon.Bee, TweenInfo.new(0.4), {Rotation = -5}):Play()
	deb += 1
	if deb >= 8 then
		fra.Icon.Bee:TweenSize(UDim2.new(1*1.15,0,1*1.15,0), "Out", "Back", 0.6, true)
		wait(0.6)
		fra.Icon.Bee:TweenSize(UDim2.new(1,0,1,0), "Out", "Back", 0.6, true)
		deb = 1
	end
	wait(0.4)
end