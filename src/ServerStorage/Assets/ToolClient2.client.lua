-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

-- Modules
local ToolsModule = require(game.ReplicatedStorage.Tools)

-- Constants
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local Tool = script.Parent
local ToolInfo = ToolsModule.Tools[Tool.Name]

local SwingAnimation = "rbxassetid://522635514"

-- Variables
local Collecting = false
local Equipped = false
local Debounce = false

-- Local Functions

-- Script Object
if not ToolInfo then warn(string.format("Tool %s is missing from ToolsModule!", Tool.Name)) return end

Tool.Equipped:Connect(function()
	Equipped = true
end)

Tool.Unequipped:Connect(function()
	Equipped = false
end)

UserInputService.InputBegan:Connect(function(Input, GPE)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Collecting = true
	end
end)

UserInputService.InputEnded:Connect(function(Input, GPE)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Collecting = false
	end
end)

ContextActionService:BindAction("Scoop", function(_, State)
	if State == Enum.UserInputState.Begin then
		Collecting = true
	else
		Collecting = false
	end
end, true, Enum.KeyCode.ButtonB)

ContextActionService:SetPosition("Scoop", UDim2.new(1, -70, 0, 10))
ContextActionService:SetTitle("Scoop", "Scoop")

while wait() do
	if Collecting and Equipped and not Debounce then
		Debounce = true
		Character.CharacterHandler.Scoop:FireServer()

		local Animation = Instance.new("Animation") 
		Animation.AnimationId = SwingAnimation

		local AnimationTrack = Humanoid:LoadAnimation(Animation)
		AnimationTrack:Play()

		wait(ToolInfo.Cooldown)
		Debounce = false

		spawn(function()
			wait(AnimationTrack.Length)
			Animation:Destroy()
		end)
	end
end
