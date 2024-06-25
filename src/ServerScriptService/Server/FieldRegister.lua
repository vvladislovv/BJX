local FieldZones = workspace.FieldZones
local ZoneModule: ModuleScript = require(game.ReplicatedStorage.Zone)
local MapZones = game.Workspace.MapZones
local Data = require(game.ServerScriptService.Server.Data)
local Utils = require(game.ReplicatedStorage.Modules.Utils)
local GetRealStats = require(game.ServerScriptService.Functions.GetRealStats)

local module = {} do
	spawn(function()
		for _,b in pairs(MapZones:GetChildren()) do
			local Zone = ZoneModule.new(b)
			Zone.playerEntered:Connect(function(Player)
				local PData = Data:Get(Player)
				local Character = game.Workspace:FindFirstChild(Player.Name)
				if Utils.CountBees(PData.Bees) < tonumber(b.Name) then
					if PData.Vars.Hive ~= "" then
						Character:SetPrimaryPartCFrame(workspace.Hives[PData.Vars.Hive].Pad.Bottom.TP.WorldCFrame)
					else
						Character:SetPrimaryPartCFrame(workspace.SpawnPlayers.Attachment.WorldCFrame)
					end
				end
			end)
		end
	end)
	--local StumpFolder = workspace:FindFirstChild("StumpFrog")
	--local Stump = StumpFolder:FindFirstChild("Stump")
	--local Zone = Zone.new(Stump)
	--Zone.playerEntered:Connect(function(Player)
	--	--FrogBoss.SummonFrog(Player)
	--end)

	--Zone.playerExited:Connect(function(Player)
	--	--FrogBoss.RemoveFrog(Player)
	--end)
	
	for _, v:Part in pairs(FieldZones:GetChildren()) do
		local Zone = ZoneModule.new(v)
		Zone.playerEntered:Connect(function(player)
			local PData = Data:Get(player)
			PData.Vars.Field = v.Name
			PData.Vars.LastField = v.Name
			if game.Players:FindFirstChild(player.Name) then
				game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(player, {"Vars", PData.Vars})
			end
		end)
		
		Zone.playerExited:Connect(function(player)
			local PData = Data:Get(player)
			PData.Vars.Field = ""
			if game.Players:FindFirstChild(player.Name) then
				game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(player, {"Vars", PData.Vars})
			end
		end)
	end
end


return module
