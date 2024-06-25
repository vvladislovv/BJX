local RunService = game:GetService("RunService")

local SPIN = -7

local model = script.Parent

RunService.Heartbeat:Connect(function(dt)
	model:PivotTo(model:GetPivot() * CFrame.Angles(0,0,math.rad(SPIN*dt)))
end)