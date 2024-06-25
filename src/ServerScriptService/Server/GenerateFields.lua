-- 29, 87, 27 - Summer/Spring Theme -- 91,154,76
-- 214, 226, 234 - Winter Theme --Ocen` =  161, 89, 25
local Module = {} do
	--// Locals \\--
	Module.MaxSize = 4
	Module.Flowers = {}
	Module.Fields = {
		["Cattail"] = {
			Flowers = {
				MiniWhite = 1,
				DoubleWhite = 25,
				TripleWhite = 1,
				MiniBlue = 1,
				DoubleBlue = 25,
				TripleBlue = 15,
				MiniRed = 0,
				DoubleRed = 0,
				TripleRed = 0,
			},
		},
		["Dandelion"] = {
			Flowers = {
				MiniWhite = 1,
				DoubleWhite = 25,
				TripleWhite = 1,
				MiniRed = 1,
				DoubleRed = 1,
				TripleRed = 1,
				MiniBlue = 1,
				DoubleBlue = 1,
				TripleBlue = 1,
			},
		},
		["Sunflower"] = {
			Flowers = {
				MiniWhite = 70,
				DoubleWhite = 2,
				TripleWhite = 0,
				MiniRed = 10,
				DoubleRed = 2,
				TripleRed = 0,
				MiniBlue =10,
				DoubleBlue = 2,
				TripleBlue = 0,
			},
		},
		["Daisy"] = {
			Flowers = {
				MiniWhite = 70,
				DoubleWhite = 10,
				TripleWhite = 0,
				MiniRed = 10,
				DoubleRed = 0,
				TripleRed = 0,
				MiniBlue = 10,
				DoubleBlue = 0,
				TripleBlue = 0,
			},
		},
		["Red Flowers"] = {
			Flowers = {
				MiniWhite = 10,
				DoubleWhite = 5,
				TripleWhite = 0,
				MiniRed = 70,
				DoubleRed = 10,
				TripleRed = 5,
				MiniBlue = 0,
				DoubleBlue = 0,
				TripleBlue = 0,
			},
		},
		["Blue Flowers"] = {
			Flowers = {
				MiniWhite = 10,
				DoubleWhite = 5,
				TripleWhite = 0,
				MiniRed = 0,
				DoubleRed = 0,
				TripleRed = 0,
				MiniBlue = 70,
				DoubleBlue = 10,
				TripleBlue = 5,
			},
		},
		["Fungus"] = {
			Flowers = {
				MiniWhite = 12,
				DoubleWhite = 5,
				TripleWhite = 3,
				MiniRed = 33,
				DoubleRed = 5,
				TripleRed = 2,
				MiniBlue = 33,
				DoubleBlue = 5,
				TripleBlue = 2,
			},
		},
		-- 5 bee zone 
		["Lemon"] = {
			Flowers = {
				MiniWhite = 4,
				DoubleWhite = 0,
				TripleWhite = 0,
				MiniRed = 4,
				DoubleRed = 0,
				TripleRed = 0,
				MiniBlue = 70,
				DoubleBlue = 25,
				TripleBlue = 5,
			},
		},
		["Cabbage"] = {
			Flowers = {
				MiniWhite = 70,
				DoubleWhite = 25,
				TripleWhite = 5,
				MiniRed = 4,
				DoubleRed = 0,
				TripleRed = 0,
				MiniBlue = 4,
				DoubleBlue = 0,
				TripleBlue = 0,
			},
		},
		["Strawberry"] = {
			Flowers = {
				MiniWhite = 5,
				DoubleWhite = 0,
				TripleWhite = 0,
				MiniRed = 30,
				DoubleRed = 15,
				TripleRed = 5,
				MiniBlue = 0,
				DoubleBlue = 0,
				TripleBlue = 0,
			},
		},
		-- 10 bee zone 
		["Pine Tree"] = {
			Flowers = {
				MiniWhite = 5,
				DoubleWhite = 0,
				TripleWhite = 0,
				MiniRed = 0,
				DoubleRed = 0,
				TripleRed = 0,
				MiniBlue = 25,
				DoubleBlue = 15,
				TripleBlue = 5,
			},
		},
		["Clover"] = {
			Flowers = {
				MiniWhite = 25,
				DoubleWhite = 15,
				TripleWhite = 5,
				MiniRed = 5,
				DoubleRed = 0,
				TripleRed = 0,
				MiniBlue = 5,
				DoubleBlue = 0,
				TripleBlue = 0,
			},
		},
		["Rose"] = {
			Flowers = {
				MiniWhite = 5,
				DoubleWhite = 0,
				TripleWhite = 0,
				MiniRed = 25,
				DoubleRed = 15,
				TripleRed = 5,
				MiniBlue = 0,
				DoubleBlue = 0,
				TripleBlue = 0,
			},
		},
		--15 bee zone
		["Tomato"] = {
			Flowers = {
				MiniWhite = 5,
				DoubleWhite = 0,
				TripleWhite = 0,
				MiniRed = 20,
				DoubleRed = 20,
				TripleRed = 10,
				MiniBlue = 0,
				DoubleBlue = 0,
				TripleBlue = 0,
			},
		},
	}
	Module.FlowerTypes = {
		["5White"] = "rbxassetid://17002508999",
		["4White"] = "rbxassetid://17002508696",
		["3White"] = "rbxassetid://17002508463",
		["2White"] = "rbxassetid://17002508287",
		["1White"] = "rbxassetid://17002508049",

		["5Red"] = "rbxassetid://17002511556",
		["4Red"] = "rbxassetid://17002511293",
		["3Red"] = "rbxassetid://17002511064",
		["2Red"] = "rbxassetid://17002510657",
		["1Red"] = "rbxassetid://17002510355",

		["5Blue"] = "rbxassetid://17002510094",
		["4Blue"] = "rbxassetid://17002509895",
		["3Blue"] = "rbxassetid://17002509748",
		["2Blue"] = "rbxassetid://17002509539",
		["1Blue"] = "rbxassetid://17002509263"
	}
	--// Functions \\--
	function GetFlowerType(FlowerName)
		local Type = {}
		if string.find(FlowerName, "Mini") then
			--Type["Size"] = "Mini"
			Type["Value"] = "1"
		elseif string.find(FlowerName, "Double") then
			--Type["Size"] = "Double"
			Type["Value"] = "2"
		elseif string.find(FlowerName, "Triple") then
			--Type["Size"] = "Triple"
			Type["Value"] = "3"
		end

		if string.find(FlowerName, "Red") then
			Type["Color"] = "Red"
		elseif string.find(FlowerName, "Blue") then
			Type["Color"] = "Blue"
		elseif string.find(FlowerName, "White") then
			Type["Color"] = "White"
		end

		Type["Texture"] = Module.FlowerTypes[FlowerName]
		return Type
	end
	function GetRandomFlower(FieldName)
		local MainTable = {}
		local Number = 0
		for i,v in pairs(Module.Fields[FieldName].Flowers) do
			if v > 0 then
				MainTable[#MainTable + 1] = { v + Number, i }
				Number = Number + v
			end
		end
		local RandomNumber = math.random(0, Number)
		for i,v in pairs(MainTable) do
			if RandomNumber <= v[1] then
				return v[2]
			end
		end
		return nil
	end
	function Module:RegisterFlower(Flower: Part)
		local FlowerType = GetFlowerType(GetRandomFlower(Flower.Parent.Name))
		local FlowerColor = FlowerType.Color
		local ID = #Module.Flowers + 1
		Flower.FlowerID.Value = ID
		Module.Flowers[ID] = {
			Color = FlowerColor,
			Stat = FlowerType,
			MaxPosition = Flower.Position.Y,
			MinPosition = Flower.Position.Y - 2.5,
			Regen = 0.3,
			GooColor = Color3.fromRGB(242, 129, 255):Lerp(Color3.fromRGB(33, 255, 171), math.abs((math.noise(Flower.Position.X / workspace.FieldZones[Flower.Parent.Name].Size.X, Flower.Position.Z / workspace.FieldZones[Flower.Parent.Name].Size.Z, math.random(1,10)) * 8) / 5)),
		}
		Flower.TopTexture.Texture = Module.FlowerTypes[Module.Flowers[ID].Stat.Value..Module.Flowers[ID].Color]
	end

	function Module:UpdateFlower(Flower: Part)
		local FlowerID = Flower:GetAttribute("FlowerID")
		if tonumber(Module.Flowers[FlowerID].Stat.Value) < Module.MaxSize then
			local BasicSize = tonumber(Module.Flowers[FlowerID].Stat.Value)
			Module.Flowers[FlowerID].Stat.Value += 1
			Flower.TopTexture.Texture = Module.FlowerTypes[Module.Flowers[FlowerID].Stat.Value..Module.Flowers[FlowerID].Color]
			spawn(function()
				wait(math.random(30,60))
				Module.Flowers[FlowerID].Stat.Value -= 1
				Flower.TopTexture.Texture = Module.FlowerTypes[Module.Flowers[FlowerID].Stat.Value..Module.Flowers[FlowerID].Color]
			end)
		end
	end

	function Module:GenerateFlower(Field, Position)
		local Flower = script.Flower:Clone()
		Flower.Parent = Field
		Flower.CFrame = Position
		Module:RegisterFlower(Flower)
	end

	function Module:GenerateField(Zone)
		local Field = Instance.new("Model", workspace.Fields)
		Field.Name = Zone.Name
		local Pos1 = Zone.Position + Vector3.new((Zone.Size.X / 2) - 2, 0, (Zone.Size.Z / 2) - 2)
		local Pos2 = Zone.Position - Vector3.new((Zone.Size.X / 2) - 2, 0, (Zone.Size.Z / 2) - 2)
		local v1 = Pos1.X - Pos1.X % 0.000000000000001
		local v2 = Pos1.Z - Pos1.Z % 0.000000000000001
		local v3 = Pos2.X - Pos2.X % 0.000000000000001
		local v4 = Pos2.Z - Pos2.Z % 0.000000000000001
		for CFrame1 = math.min(v1, v3), math.max(v1, v3), 3.5 do
			for CFrame2 = math.min(v2, v4), math.max(v2, v4), 3.5 do
				spawn(function()
					Module:GenerateFlower(Field, CFrame.new(CFrame1, Pos1.Y, CFrame2))
				end)
			end
		end
	end
	--// Generate \\--
	for i,v in pairs(workspace.FieldZones:GetChildren()) do
		spawn(function()
			Module:GenerateField(v)
		end)
	end
end

return Module