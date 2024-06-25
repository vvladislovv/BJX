local Token = {}; do
	local DataServer = require(game.ServerScriptService.Server.Data)
	local Flowers = require(game.ServerScriptService.Server.FlowerRegister)

	function Token.Run(Player: Player, Position: Vector3, Type: string)
		local PlayerData = DataServer:Get(Player)
		local Color = string.find(Type, "Blue") and "Blue" or string.find(Type, "Red") and "Red" or "White"
		local Plus = string.find(Type, "+")
		Flowers:CollectPatches(Player, {
			Position = Position + Vector3.new(0, 1, 0),
			Stamp = not Plus and "Bomb" or "BombPlus",
			StatsModule = {
				Collecting = 15 * (Plus and 2 or 1),
				Power = 1,
				Color = Color,
				ColorMutltiplier = 1.5
			}
		})
	end
end

return Token