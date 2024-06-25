local ts = game:GetService("TweenService")
local pp = script.Parent

while wait(1) do
	ts:Create(pp, TweenInfo.new(1), {BackgroundColor3 = Color3.fromRGB(126, 236, 102)}):Play()
	wait(1)
	ts:Create(pp, TweenInfo.new(1), {BackgroundColor3 = Color3.fromRGB(52, 173, 128)}):Play()
end