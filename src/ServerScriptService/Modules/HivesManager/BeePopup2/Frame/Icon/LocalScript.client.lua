local eye = script.Parent.UIGradient
local ts = game:GetService("TweenService")
--43--49---55
while wait(2) do
	ts:Create(eye, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Offset = Vector2.new(1.25,0)}):Play()
	wait(1)
	eye.Offset = Vector2.new(-0.5,0)
end