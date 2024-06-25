local module = {}

module["Seed"] = {
	Timer = 20,
	Type = "Item",
	Decal = "rbxassetid://17120179581",
	Sound = "Item",
	ColorT = "None",
	Debounce = 0.1,
	TokenColor = Color3.fromRGB(79, 223, 245)
}

module["Honey"] = {
	Timer = 20,
	Type = "Currency",
	Decal = "rbxassetid://15028813852",
	Sound = "",
	ColorT = "None",
	Debounce = 0.1,
	TokenColor = Color3.fromRGB(245, 189, 58)
}

for Name, Data in require(game.ReplicatedStorage.Modules.Items).Eggs do
	if not module[Name] and (Data.Type ~= "Hydrant") then
		module[Name] = {
			Timer = 20,
			Type = "Item",
			Decal = Data.Image,
			Sound = "Item",
			ColorT = "None",
			Debounce = 0.1,
			TokenColor = Color3.fromRGB(79, 223, 245),
		}
	end
end

print(module)

return module
