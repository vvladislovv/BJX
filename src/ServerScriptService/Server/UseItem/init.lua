local Modules = game.ReplicatedStorage:WaitForChild("Modules")
local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")
local Utils = require(Modules:WaitForChild("Utils"))
local SSS = game:GetService("ServerScriptService")
local Data = require(script.Parent.Data)
local TS = game:GetService("TweenService")
local BadgeService = game:GetService("BadgeService")
local Equipment = require(script.Parent.Equipment)
local Bees = game.ReplicatedStorage.Bees
local Levels = require(Modules.BeeLevels)
local Items = require(Modules.Items).Eggs
local DataMod = require(SSS.Functions.DataModifier)
local QuestRoad = require(SSS.Functions.QuestRoad.UseItem)
local Sprouts = require(SSS.Server.Sprouts)
--local Hydrants = require(SSS.Modules.HydrantBuilder)

local Debs = {}
local Debs2 = {}
local Debs3 = {}

local DebsEmo = {}
local Events = {} do
	Remotes.UseItem.OnServerEvent:Connect(function(Player, Item)
		local PData = Data:Get(Player)
		if tonumber(PData.Inventory[Item]) >= 1 and not Items[Item].Removed then
			if not PData.Cooldowns[Item] or PData.Cooldowns[Item].Time - os.time() <= 0 then
				if Items[Item].Type == "Boost" then
					game.ReplicatedStorage.Remotes.Boost:Fire(Player, Item, 1)
					wait(0.2)
					DataMod.InventoryChange(Player, {"-", 1, Item, "from Treasure Box", false})
					--QuestRoad.QuetRoad(Player, Item)
				--elseif Items[Item].Type == "Hydrant" then
					--if PData.Vars.Field ~= "" and PData.Equipment.Hydrant ~= "" then
					--	Hydrants.PlaceHydrant(Player, PData)
					--end
				elseif Items[Item].Type == "Sprout" then
					if PData.Vars.Field == "" then
						Remotes.AlertClient:FireClient(Player, {
							Color = "Red",
							Msg = "You have to be in the Field to use the Sprout"
						})
					else
						if not workspace.FieldZones[PData.Vars.Field]:FindFirstChild("Sprout") then
							Sprouts.Spawn(Item, PData.Vars.Field, Player)
							DataMod.InventoryChange(Player, {"-", 1, Item, "from Treasure Box", false})
							DataMod.MakeCooldown(Player, {"Sprout", 3})
						end
					end
				else
					print(Items[Item].Type)
					require(script:FindFirstChild(Items[Item].Type)).Use(Player, Item)
				end
				_G.CompleteQuest(Player, "UseItem", {
					Item = Item,
					Amount = 1,
				})
			end
		end
	end)
end

return Events