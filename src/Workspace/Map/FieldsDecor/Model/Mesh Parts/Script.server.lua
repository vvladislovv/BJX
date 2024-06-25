local part = script.Parent
local ts = game:GetService("TweenService")

spawn(function()
	while wait(2) do
		ts:Create(part, TweenInfo.new(2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = Vector3.new(13,5,13)}):Play()
		wait(2)
		ts:Create(part, TweenInfo.new(2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = Vector3.new(10,4,10)}):Play()
	end
end)