local InfoHover = {}

local screenGui = nil
local TextMsg = "Some problems with connecting to Hover Service"
local UserInputService = game:GetService("UserInputService")
local box = Instance.new("TextLabel")
box.Name = "MouseoverBox"
box.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
box.BackgroundTransparency = 0.2
box.Font = Enum.Font.Highway
box.TextSize = 25
box.RichText = true
box.TextScaled = false
box.TextWrapped = true
box.AnchorPoint = Vector2.new(0, 0)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Visible = false
box.ZIndex = 9999
local Corner = Instance.new("UICorner", box)
Corner.CornerRadius = UDim.new(0,8)
--local UIStroke = Instance.new("UIStroke", box)
--UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
--UIStroke.Thickness = 5
--UIStroke.Color = Color3.fromRGB(21, 21, 21)


--function InfoHover:Create(MousePos)
--	local bounds = box.TextBounds
--	box.Size = UDim2.new(0, bounds.X * 1.75, 0, bounds.Y * 1.75)
--	if not TextL then
--		box.Position = MousePos
--		box.Visible = true
--	else
--		box.Text = TextL
--		box.Position = MousePos
--		box.Visible = true
--	end
--end

function InfoHover:Remove(Frame)
	if not Frame then
		box.Visible = false
	else
		Frame.Visible = false
	end
end

function InfoHover:Move(MousePos, SizeMult, XPoint, Frame)
	if not XPoint then
		XPoint = Vector2.new(0, 0)
	end
	if not Frame then
		local bounds = box.TextBounds
		box.AnchorPoint = XPoint
		box.Size = UDim2.new(0, (bounds.X / SizeMult) + 85, 0, (bounds.Y / SizeMult))
		box.Position = MousePos
		box.Visible = true
	else
		Frame.AnchorPoint = XPoint
		Frame.Position = MousePos
		Frame.Visible = true
	end
end

function InfoHover:UpdateText(TextL)
	TextMsg = TextL 
end

function InfoHover.Init()
	local players = game:GetService("Players")
	local player = players.LocalPlayer
	local pGui = player:WaitForChild("PlayerGui")
	screenGui = pGui:WaitForChild("UI")
	box.Parent = screenGui
	spawn(function()
		while wait(0.0001) do
			box.Text = TextMsg
		end
	end)
end

return InfoHover
