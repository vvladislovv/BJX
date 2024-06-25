local TweenService = game:GetService("TweenService")

--local Alerts = {}

local getFrame = function()
	local players = game:GetService("Players")
	local player = players.LocalPlayer
	local playerGui = player.PlayerGui
	local screenGui = playerGui:WaitForChild("UI")
	local frame = screenGui:WaitForChild("Alerts")
	return frame
end

local MaxAlerts = 7
local Transparency = 0.25
local Time = 0.5
local LifeSpawn = 10
local alertSize = UDim2.new(1, 0, 1 / MaxAlerts, 0)
local Alerts = {}
local CopyAlerts = {}

local Colors = {
	Blue = Color3.fromRGB(71, 141, 231),
	Red = Color3.fromRGB(201, 39, 28),
	Purple = Color3.fromRGB(181, 118, 186),
	Purple2 = Color3.fromRGB(248, 162, 255),
	White = Color3.fromRGB(213, 213, 213),
	Orange = Color3.fromRGB(255, 180, 51),
	Night = Color3.fromRGB(24, 24, 24),
	Cave = Color3.fromRGB(108, 84, 65),
	Cave2 = Color3.fromRGB(68, 52, 41),
	BeePass = Color3.fromRGB(24, 24, 24),
}

local TextColors = {
	BeePass = Color3.fromRGB(255, 232, 99)
}

function cleanUp()
	local kill = {}
	local keep = {}
	for i, v in ipairs(Alerts) do
		if v.Transparency >= 0.999 then
			table.insert(kill, v)
			
		else
			table.insert(keep, v)
		end
	end
	Alerts = keep
	for _, v in ipairs(kill) do
		v:Destroy()
	end
end

local function MakeAlertBox(msg, color, textcolor)
	local box = script.Template:Clone()
	box.Parent = getFrame()
	box.Text = msg
	box.Size = UDim2.new(0, 0, alertSize.Y.Scale, 0)
	box.Position = UDim2.new(0, 0, 1 - alertSize.Y.Scale, 0)
	box.BackgroundTransparency = Transparency
	box:TweenSize(alertSize, "Out", "Elastic", Time, true)
	if color ~= nil then
		local c = Colors[color]
		if c ~= nil then
			box.BackgroundColor3 = c
		end
		if textcolor ~= nil then
			box.TextColor3 = TextColors[textcolor]
		else
			box.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end
	local goal = {}
	goal.Transparency = 1
	local tt = LifeSpawn * 0.8
	local tdelay = LifeSpawn - tt
	local tweenInfo = TweenInfo.new(tt, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, tdelay)
	local tween = TweenService:Create(box, tweenInfo, goal)
	tween:Play()
	table.insert(Alerts, box)
	--game.StarterGui:SetCore("ChatMakeSystemMessage", {
	--	Text = "[" .. msg .. "]",
	--	FontSize = Enum.FontSize.Size24
	--})
end

local function tweenAlerts()
	local count = #Alerts
	for i, v in ipairs(Alerts) do
		local offsetID = 1 + (count - i)
		local pos = UDim2.new(0, 0, 1 - offsetID * (1 / MaxAlerts + 0.05), 0)
		local tt = Time + i / count * Time
		if v.Parent == getFrame() then
			v:TweenPosition(pos, "Out", "Elastic", tt, true)
		end
	end
end

function Alerts.Alert(Info)
	local Text = Info.Msg
	MakeAlertBox(Info.Msg, Info.Color, Info.TextColor)
	tweenAlerts()
	spawn(function()
		wait(LifeSpawn * 1.05)
		cleanUp()
	end)
end


return Alerts
