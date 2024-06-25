local StarterGui = game:GetService("StarterGui")
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Remotes = game:GetService("ReplicatedStorage").Remotes
local UIS = game:GetService("UserInputService")
local ParachuteSys = require(game.ReplicatedStorage.Modules.Client.Parachute)
local CD = math.random(30,180)
local Sounds = game:GetService("SoundService")

local SoundsTable = {
	[1] = "BirdSong",
	[2] = "BirdSpirits"
}

--repeat wait() until StarterGui:GetCore("ChatWindowSize") ~= nil
--local chatWindowSize = StarterGui:GetCore("ChatWindowSize")

--StarterGui:SetCore("ChatWindowPosition", UDim2.new((1 - chatWindowSize.X.Scale), 0, 0, 0))
--StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

--local ClientFunctions = require(game.ReplicatedStorage.Modules.Client.ClientFunctions).Start(Player)
local ParachuteSystem = require(game.ReplicatedStorage.Modules.Client.ParachuteSystem).Start(Player)

repeat _G.PData = game.ReplicatedStorage.Remotes.GetPlayerData:InvokeServer() until _G.PData
Character:WaitForChild("Humanoid").Died:Connect(function()
	Remotes.Death:FireServer(Player)
	Player.CharacterAdded:Wait()
	_G.PData = Remotes.GetPlayerData:InvokeServer()

	ParachuteSystem = require(game.ReplicatedStorage.Modules.Client.ParachuteSystem).Start(Player)
end)

UIS.InputBegan:Connect(function(key, gpe)
	if not gpe and key.KeyCode == Enum.KeyCode.C then
		Remotes.Item:FireServer("Caramel")
	end
end)

local function SetValue(Sound, Value)
	while Sound.Volume >= 0.35 do
		Sound.Volume = tonumber(string.format("%.2f", Sound.Volume - 0.05))

		wait(0.03)
	end
end

local function PlaySound(Sound, Type)
	if Type == "Token" then
		Sounds.Tokens[Sound]:Play()
	elseif Type == "Ambient" then
		while Sounds.MainBackground.Volume >= 0.35 do
			Sounds.MainBackground.Volume = tonumber(string.format("%.2f", Sounds.MainBackground.Volume - 0.05))
			
			wait(0.03)
		end
		Sounds.Ambient[Sound]:Play()
		task.wait(Sounds.Ambient[Sound].TimeLength-3)
		while Sounds.MainBackground.Volume <= 1 do
			Sounds.MainBackground.Volume = tonumber(string.format("%.2f", Sounds.MainBackground.Volume + 0.05))
			
			wait(0.03)
		end
	elseif Type == "Sound" then
		Sounds[Sound]:Play()
	end
end

if _G.PData.Options.Music == true then
	game.SoundService.MainBackground.Volume = 1
else
	game.SoundService.MainBackground.Volume = 0
end

game.ReplicatedStorage.Remotes.PlaySound.OnClientEvent:Connect(function(Info)
	PlaySound(Info.Sound, Info.Type)
end)

while wait(5) do
	if CD <= 0 then
		local Info = {
			Sound = SoundsTable[math.random(1, 2)],
			Type = "Ambient"
		}
		PlaySound(Info.Sound, Info.Type)
		CD = math.random(180, 600)
	else
		CD -= 5
	end
end