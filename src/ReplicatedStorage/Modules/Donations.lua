local Remotes = game.ReplicatedStorage.Remotes


local module2 = {
	["DevSup"] = { -- 79R$
		ID = 1747832723,
		Type = "Product",

		Func = function(Player, PData)
			PData.IStats.Honey += 5000
			PData.Badges.Honey.Amount += 5000
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
		end
	},
}

return module2