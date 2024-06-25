wait(4)

local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage.Remotes
local Tools = require(game.ReplicatedStorage:WaitForChild("Modules").Equipment.Collectors).Collectors

local ToolInfo = Tools[_G.PData.Equipment.Tool]
local AnimCustom = Tools[_G.PData.Equipment.Tool].AnimTools -- кастом в блоке StatsModule
if not ToolInfo then warn("Tool is not in module!") return end

local Collecting = false
local Debounce = false


local v5 = Player:GetMouse()
v5.Button1Down:Connect(function()
	Collecting = true
end)
v5.Button1Up:Connect(function()
	Collecting = false
end)
--if UIS.TouchEnabled then
--	UIS.TouchStarted:Connect(function(Input, GPE)
--		if not GPE and Input.UserInputType == Enum.UserInputType.MouseButton1 then
--			Collecting = true
--		end
--	end)
--	UIS.TouchEnded:Connect(function(Input, GPE)
--		if not GPE and Input.UserInputType == Enum.UserInputType.MouseButton1 then
--			Collecting = false
--		end
--	end)
--end

--UIS.InputBegan:Connect(function(Input, GPE)
--	if not GPE and Input.UserInputType == Enum.UserInputType.MouseButton1 then
--		Collecting = true
--	end
--end)
--UIS.InputEnded:Connect(function(Input, GPE)
--	if not GPE and Input.UserInputType == Enum.UserInputType.MouseButton1 then
--		Collecting = false
--	end
--end)


game:GetService("RunService").RenderStepped:Connect(function()
	if Collecting and not Debounce then
		Debounce = true
		script.Parent.Server.Collect:FireServer(HRP)

		local Animation = Instance.new("Animation")
		Animation.AnimationId ="rbxassetid://522635514"

		local AnimationTrack = Humanoid:LoadAnimation(Animation)
		local Cooldown = ToolInfo.Cooldown-- / (PData.AllStats["Tools Speed"] / 100)
		AnimationTrack:Play()

		task.wait(Cooldown)

		Debounce = false

		task.spawn(function()
			wait(AnimationTrack.Length)
			Animation:Destroy()
		end)
	end
end)