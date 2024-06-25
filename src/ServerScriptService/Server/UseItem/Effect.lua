local Module = {}; do
	local Data = require(script.Parent.Parent.Data)
	local DataModifier = require(game.ServerScriptService.Functions.DataModifier)
	local Remotes = game.ReplicatedStorage.Remotes
	
	function Module.Use(Player: Player, Item: string)
		local PlayerData = Data:Get(Player)
		
		if Item == "Instant Converter" then
			if PlayerData.IStats.Pollen > 0 then
				local Pollen = PlayerData.IStats.Pollen
				DataModifier.IStatsChange(Player, {"-", Pollen, "Pollen"})
				DataModifier.IStatsChange(Player, {"+", Pollen, "Honey", "Instant Converter", true})
			else
				return Remotes.AlertClient:FireClient(Player, {
					Msg = "You must have pollen in your bag!",
					Color = "Red"
				})
			end
		elseif Item == "Fertilizer" then
			if PlayerData.Vars.Field == "" then
				return Remotes.AlertClient:FireClient(Player, {
					Msg = "You must stay at the field!",
					Color = "Red"
				})
			else
				Remotes.Boost:Fire(Player, PlayerData.Vars.Field.." Field", 1)
				DataModifier.MakeCooldown(Player, {Item, 60*15})
			end
		end
		
		DataModifier.InventoryChange(Player, {"-", 1, Item})
	end
end

return Module