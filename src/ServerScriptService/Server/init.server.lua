local Modules = game.ReplicatedStorage:WaitForChild("Modules")
local Utils = require(Modules:WaitForChild("Utils"))
local FieldZones = game.Workspace.FieldZones
local Zone = require(game.ReplicatedStorage.Zone)
local Data = require(script.Data)

--local Equipment = require(script.Equipment)
--local Data = require(script.Data)
Utils:Load(script)
--for _,v in pairs(FieldZones:GetChildren()) do
--	local Zone = Zone.new(v)
--	print(v.Name)
--	Zone.playerEntered:Connect(function(Player)
--		local PData = Data:Get(Player)
--		print(v.Name)
--		PData.Vars.Field = v.Name
--		PData.Vars.LastField = v.Name
--		if game.Players:FindFirstChild(Player.Name) then
--			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Vars", PData.Vars})
--		end
--	end)

--	Zone.playerExited:Connect(function(Player)
--		local PData = Data:Get(Player)
--		PData.Vars.Field = ""
--		if game.Players:FindFirstChild(Player.Name) then
--			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Vars", PData.Vars})
--		end
--	end)
--end
--game.Players.PlayerAdded:Connect(function(Player)
--	wait(5)
--	local Character = game.Workspace:WaitForChild(Player.Name)
--	local PData = Data:Get(Player)

--	Equipment.Load(Player, PData, Character)
--	Equipment.StartTimers(Player, PData)
--end)

game.Players.PlayerAdded:Connect(function(player)
	wait(3)
	if player and player.Character then
		for i,v in player.Character:GetDescendants() do
			v:AddTag("Player")
			v:SetAttribute("playerName", player.Name)
		end
	end
end)