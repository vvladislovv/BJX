local Boost = script.Parent
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
--local ySize = math.clamp(BoostTime / Boosts[Boost.Name].Time, 0, 1)
--script.Parent.Bar.Size = UDim2.new(1,0,ySize,0)
-- Modules
local Utilities = require(ReplicatedStorage.Utilities)
local Items = require(ReplicatedStorage.Modules.Items)
local Modules = ReplicatedStorage.Modules
-- Constants
local UI = script.Parent.Parent.Parent
--local InfBoosts = require(UI.InfBoosts)

local Remotes = ReplicatedStorage.Remotes
local PData = _G.PData
local Boosts = game.ReplicatedStorage.Boosts

local UIScale = UI:WaitForChild("UIScale")

-- Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HoverInfo = require(ReplicatedStorage.Modules.InfoHover)
local Data
local Utils = require(ReplicatedStorage.Modules.Utils)
Scale = UI.AbsoluteSize.Y / 1080 * 1.1
local CanUpdate = false
local HoverText
local BoostTime
local PDataBoostAm = 1
local Mod


function UpdateBuffStats()
	if not script.Parent.BDisabled.Value then
		if script.Parent.Type.Value ~= "Thing" then
			Mod = require(Boosts[Boost.Name])
			if Mod.Passive then
				script.Parent.BackgroundTransparency = 1
				BoostText = "+Passive "..Mod.Name.."\n"..Mod.Desc
			else
				BoostText = ''
				local allbuffs = {}
				for k = 1, #Mod.StringNames do
					if Mod then
						if Mod.Boosts then
							if Mod.Boosts[k].Amount and PData.Boosts[Boost.Name] then
								local YtxM = Mod.Boosts[k].Amount * math.round(PData.Boosts[Boost.Name].Amount)  --+ (PDataBoostAm / 10) - 0.1 + 1
								local Ytx = Mod.Boosts[k].Amount * math.round(PData.Boosts[Boost.Name].Amount)
								local Txt1
								if Mod.Boosts[k].Mod == "Mult" then
									if Mod.Boosts[k].Amount < 1 then
										if PData.Boosts[Boost.Name].Amount < 1 then
											YtxM = (Mod.Boosts[k].Amount + 1) * math.round(PData.Boosts[Boost.Name].Amount)
										else
											YtxM = (Mod.Boosts[k].Amount + 1)
										end
									else
										YtxM = Mod.Boosts[k].Amount * math.round(PData.Boosts[Boost.Name].Amount)
									end
								elseif Mod.Boosts[k].Mod == "Percent" then
									Txt1 = "+"..Ytx.."% "..Mod.StringNames[k]
								elseif Mod.Boosts[k].Mod == "Add" then
									Txt1 = "+"..Ytx.." "..Mod.StringNames[k]
								elseif Mod.Boosts[k].Mod == "MinusPercent" then
									Txt1 = "-"..Ytx.."% "..Mod.StringNames[k]
								elseif Mod.Boosts[k].Mod == "Set" then
									Txt1 = "+"..Ytx.." "..Mod.StringNames[k]
								end
								
								allbuffs[k] = Txt1
								if #allbuffs == #Mod.StringNames then
									for i, v in pairs(allbuffs) do
										if (i ~= 1) then
											BoostText = BoostText.. '\n'
										end
										BoostText = BoostText.. v
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local BoostSize = Boost.Size
Boost.MouseEnter:Connect(function()
	Boost:TweenSize(UDim2.new(0.1*1.1, 0, 1*1.1, 0), "Out", "Back", 0.2, true)
	HoverInfo:UpdateText(HoverText)
	CanUpdate = true
	HoverInfo:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
end)
Boost.MouseLeave:Connect(function()
	Boost:TweenSize(UDim2.new(0.1, 0, 1, 0), "Out", "Back", 0.2, true)
	CanUpdate = false
	HoverInfo:Remove()
end)
Boost.MouseMoved:Connect(function()
	Scale = UI.AbsoluteSize.Y / 1080 * 1.075
	HoverInfo:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if script.Parent.Visible then
		wait(1)
		local BoostModule = require(game.ReplicatedStorage.Boosts[script.Parent.Name])
		PData = _G.PData
		if PData.Boosts[Boost.Name] then
			BoostTime = PData.Boosts[Boost.Name].Time - os.time()
		end
		if script.Parent.Visible then
			UpdateBuffStats()
			script.Parent.Fill.Size = UDim2.new(1,0,math.clamp(BoostTime/BoostModule.Time, 0, 1)*1,0)
			HoverText = Boost.Name.."\n"..BoostText.."\n"..Utilities:FormatTime(BoostTime)
			if CanUpdate then
				HoverInfo:UpdateText(HoverText)
			end
		end
	end
end)