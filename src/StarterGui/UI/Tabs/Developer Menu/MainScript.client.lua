wait(5)
--// Player
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
--// UI
local UI = script.Parent.Parent.Parent
local UIScale = UI:WaitForChild("UIScale")
--// Services 
local SocialService = game:GetService("SocialService")
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Remotes = game.ReplicatedStorage.Remotes
local bees = game.ReplicatedStorage.Bees

--// Modules
local Utils = require(game.ReplicatedStorage.Modules.Utils)
local Hovers = require(game.ReplicatedStorage.Modules.InfoHover)
local Eggs = require(game.ReplicatedStorage.Modules.Items).Eggs
local Alerts = require(game.ReplicatedStorage.Modules.Alerts)
local Shops = require(game.ReplicatedStorage.Modules.UI.Shops)
local BeeLevels = require(game.ReplicatedStorage.Modules.BeeLevels)
local Quests = require(game.ReplicatedStorage.Modules.UI.Quests)

--// Vars
local Scale = UIScale.Scale
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()
local Humanoid = Player.Character:WaitForChild("Humanoid")
local i = 99900

script.Parent.Handler.RankFrame.Rank.Text = "Your rank: <font color=\"#f33\">".._G.PData.IStats.Rank.."</font>"

local function openFunction(func: IntValue)
	local IMod = require(func)
	script.Parent:TweenPosition(UDim2.new(0.5, 0, 3, 0), "Out", "Back", 0.6)
	script.Parent.Parent[func.Name]:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.6)
end

local function init()
	for id, func in pairs(game.ReplicatedStorage.AdminFunctions:GetChildren()) do
		local IMod = require(func)
		local Ex

		local access = false;
		for _, Rank in pairs(IMod.Ranks) do
			if(_G.PData.IStats.Rank == "OWNER") then
				access = true
			end
			if(_G.PData.IStats.Rank == Rank) then
				access = true
				break
			end
		end
		if(access == false) then -- Если нет доступа:
			Ex = script.NoAccessFunctionExample:Clone()
			Ex.LayoutOrder = i
			i += 1
		else -- Если есть доступ:
			Ex = script.FunctionExample:Clone()
			Ex.Description.TextLabel.Text = IMod.Description
			Ex.LayoutOrder = IMod.Layout
			Ex.MouseButton1Click:Connect(function()
				script.Click:Play()
				openFunction(func)
			end)
		end

		Ex.Visible = true
		Ex.Name = IMod.Name
		Ex.Title.TextLabel.Text = IMod.StringNames[1]
		Ex.Icon.Image = IMod.Image

		Ex.Parent = script.Parent.Handler.List

		Ex.MouseEnter:Connect(function()
			script.Enter:Play()

			Ex.Icon:TweenSize(UDim2.new(0.279, 0, 0.96, 0), "Out", "Elastic", 0.35, true)
			TS:Create(Ex.Icon, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 6}):Play()
		end)
		Ex.MouseLeave:Connect(function()
			TS:Create(Ex.Icon, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
			Ex.Icon:TweenSize(UDim2.new(0.223, 0, 0.8, 0), "Out", "Elastic", 0.35, true)
		end)
	end
end
init()