local A = {
	["Instant"] = true,
	["Red Instant"] = true,
	["Blue Instant"] = true,
	["White Instant"] = true,
	["Movement Collection"] = true,
	["Critical Chance"] = true,
	["Bomb Instant"] = true,
	["White Bomb Instant"] = true,
	["Red Bomb Instant"] = true,
	["Total Converts"] = true,
	["Blue Bomb Instant"] = true,
	["Bee's Attack"] = true,
	["Red Bee's Attack"] = true,
	["Colorless Bee's Attack"] = true,
	["Blue Bee's Attack"] = true,
	["Convert Amount"] = true,
}
local blacklist = {
	["Tool"] = true,
	["Tools"] = true,
	["Glider"] = true,
	["Gliders"] = true,
	["Hydrant"] = true,
	["Hydrants"] = true,
}
local bees = game.ReplicatedStorage.Bees
local bags = require(game.ReplicatedStorage.Modules.Equipment.Bags).Bags
local Badges = require(game.ReplicatedStorage.Modules.Badges).Badges

local BoostsHandler = {} do
	function BoostsHandler.GetRealStats(Player, PData)
		local NewStats = {}
		local GiftedBees = {}
		local newcap = 0
		
		for Name, Am in pairs(PData.AllStats) do
			if not A[Name] then
				NewStats[Name] = 100
			else
				NewStats[Name] = 0
			end
		end
		NewStats["Capacity"] = 100
		
		for BType, BTab in pairs(Badges) do
			if PData.Badges[BType].Tier > 1 then
				NewStats[BTab.BuffType] += BTab[PData.Badges[BType].Tier - 1].BuffAmount
			end
		end
		for B, Bee in pairs(PData.Bees) do
			if Bee.Gifted and Bee.BeeName ~= "" then
				GiftedBees[Bee.BeeName] = true
			end
		end
		for EqType, Eq in pairs(PData.Equipment) do
			if not blacklist[EqType.."s"] and not blacklist[EqType] then
				if game.ReplicatedStorage.Modules.Equipment:FindFirstChild(EqType.."s") and Eq ~= nil and Eq ~= "" then
					local EqTab = require(game.ReplicatedStorage.Modules.Equipment:FindFirstChild(EqType.."s"))[EqType.."s"]
					if EqTab[Eq].Capacity then
						newcap += EqTab[Eq].Capacity
					end
					if EqTab[Eq].Buffs then
						for i,v in pairs(EqTab[Eq].Buffs) do
							if v[2] == "Percent" then
								NewStats[v[1]] += v[3]
							elseif v[2] == "Multiplier" then
								if not A[v[1]] then
									NewStats[v[1]] *= v[3]
								end
							end
						end
					end
				end
			end
		end
		if PData.Boosts ~= {} then
			for BoostName, Info in pairs(PData.Boosts) do
				if game.ReplicatedStorage.Boosts:FindFirstChild(Info.BoostType) then
					local BoostInfo = require(game.ReplicatedStorage.Boosts[Info.BoostType])
					for i,v in pairs(BoostInfo.Boosts) do
						if v.Mod == "Percent" and NewStats[v.Type] ~= nil and v.Amount ~= nil then
							NewStats[v.Type] += (v.Amount * Info.Amount)
						elseif v.Mod == "Mult" and NewStats[v.Type] ~= nil and v.Amount ~= nil then
							if not A[v.Type] then
								if Info.Amount < 1 then
									if v.Amount <= 1 then
										NewStats[v.Type] *= ((Info.Amount + 1) * v.Amount)
									else
										NewStats[v.Type] *= ((Info.Amount + 1) * 1)
									end
								else
									NewStats[v.Type] *= (Info.Amount * v.Amount)
								end
							end
						elseif v.Mod == "MinusPercent" and NewStats[v.Type] ~= nil and v.Amount ~= nil then
							NewStats[v.Type] -= (v.Amount * Info.Amount)
						end
					end
				end
			end
		end
		
		for i,v in pairs(GiftedBees) do
			local bmod = require(bees[i]).GiftedBonus
			if bmod[2] == "Mult" then
				NewStats[bmod[1]] *= bmod[3]
			else
				NewStats[bmod[1]] += bmod[3]
			end
		end
		for NameQ, AmQ in pairs(PData.AllStats) do
			PData.AllStats[NameQ] = math.round(NewStats[NameQ])
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"AllStats", NameQ, math.round(NewStats[NameQ])})
			PData.IStats.Capacity = newcap * (PData.AllStats["Capacity"] / 100)
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats","Capacity", newcap * (PData.AllStats["Capacity"] / 100)})
		end
	end
end

return BoostsHandler