local Modules = game.ReplicatedStorage:WaitForChild("Modules")
local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")
local Utils = require(Modules:WaitForChild("Utils"))
local Data = require(script.Parent.Data)
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("CodeDataStore_BJ_X1")
local CodeModule = require(game.ServerScriptService:WaitForChild("CodeData"))
local TS = game:GetService("TweenService")
local BadgeService = game:GetService("BadgeService")
local Equipment = require(script.Parent.Equipment)
local Bees = game.ReplicatedStorage.Bees
local Levels = require(Modules.BeeLevels)
local Classes = game.ServerScriptService["Webhook Testing"].Classes;
local DiscordEmbed = require(Classes.Embed);
local Webhook = require(Classes.WebhookClient);

local Debs = {}
local Debs2 = {}
local Debs3 = {}

local DebsEmo = {}
local Events = {} do
	for _, Player in game.Players:GetPlayers() do
		spawn(function()
			wait(3)
			local PData = Data:Get(Player)
			local Character = Player.Character or Player.CharacterAdded:Wait()
			Equipment.Load(Player, PData, Character)
		end)
	end
	game.Players.PlayerAdded:Connect(function(Player)
		wait(3)
		local PData = Data:Get(Player)
		local Character = Player.Character
		Player.CameraMaxZoomDistance = 65

		if PData.IStats.LastDN ~= workspace.DailyHoney.Last.Value then
			PData.IStats.LastDN = workspace.DailyHoney.Last.Value
			PData.Daily.Honey = 0
		else
			PData.IStats.LastDN = workspace.DailyHoney.Last.Value
		end
		Equipment.Load(Player, PData, Character)
		Equipment.StartTimers(Player, PData)
	end)

	game.Players.PlayerRemoving:Connect(function(Player)
		wait(0.1)
		local PData = Data:Get(Player)
		workspace.PlayersE[Player.Name]:Destroy()

		if PData.Vars.Hive ~= "" and PData.Vars.Hive ~= nil then
			workspace.Hives[PData.Vars.Hive].Pad.Circle.Gui.TextLabel1.Text = ""
			workspace.Hives[PData.Vars.Hive].Pad.Circle.Gui.TextLabel1.TextLabel1.Text = ""

			workspace.Hives[PData.Vars.Hive].Pad.Circle.Gui.TextLabel2.Text = ""
			workspace.Hives[PData.Vars.Hive].Pad.Circle.Gui.TextLabel2.TextLabel2.Text = ""

			workspace.Hives[PData.Vars.Hive].Pad.Bottom.Transparency = 1
			workspace.Hives[PData.Vars.Hive].Pad.FF2.Transparency = 0

			workspace.Hives[PData.Vars.Hive].Display.Gui.TextLabel1.Text = ""
			workspace.Hives[PData.Vars.Hive].Display.Transparency = 1
			workspace.Hives[PData.Vars.Hive].FF.Transparency = 1

			workspace.Hives[PData.Vars.Hive].Owner.Value = ""

			for i,v in pairs(workspace.Hives[PData.Vars.Hive].Slots:GetChildren()) do
				v.Color = Color3.fromRGB(25, 25, 25)
				v.Transparency = 0.5
				v.BeeN.Value = ""
				if tonumber(v.Name) > 5 then
					v:Destroy()
				end
				if v:FindFirstChild("Dc") then
					v:FindFirstChild("Dc"):Destroy()
				end
				if v:FindFirstChild("Outline") then
					v:FindFirstChild("Outline"):Destroy()
				end
			end
		end
	end)

	Remotes.ConvertPollen.OnServerEvent:Connect(function(Player, Status)
		local PData = Data:Get(Player)
		PData.Vars.Making = Status
	end)
	Remotes.ClaimHive.OnServerEvent:Connect(function(Player, Hive)
		_G.Hives.NewHive(Player, Hive)
	end)
	Remotes.OpenFoodGui.OnServerEvent:Connect(function(Player, Treat)
		Remotes.OpenFoodGui:FireClient(Player, Treat)
	end)
	Remotes.CreateBeeSlot.OnServerEvent:Connect(function(Player, Item, Slot)
		_G.Hives.CreateBeeSlot(Player, Item, Slot)
	end)
	
	--Codes
	local function IsValidCode(key)
		if DataStore:GetAsync("codeData/codes/"..key) ~= nil then
			return true
		else
			return false
		end
	end
	local function GetCodeItems(key)
		if IsValidCode(key) then
			local itemsTable = DataStore:GetAsync("codeData/codeItems/"..key)
			return itemsTable
		end
	end
	Remotes.RemoveCode.OnServerEvent:Connect(function(Player, code)
		local PData = Data:Get(Player)
		if(PData.IStats.Rank == "OWNER" or PData.IStats.Rank == "ADMIN" or PData.IStats.Rank == "MODERATOR" or PData.IStats.Rank == "DEVELOPER") then
			CodeModule.RemoveCode(code)
			Remotes.AlertClient:FireClient(Player, {
				Color = "Red",
				Msg = "Deleted code: "..code
			})
		end
	end)
	Remotes.UseCode.OnServerEvent:Connect(function(plr, CodePlayer)
		local Code = CodePlayer
		local PData = Data:Get(plr)
		local CodeData = require(game.ServerScriptService.CodeData)

		if IsValidCode(Code) and not PData.Codes[Code] then
			if CodeData.Get(Code) then
				local Uses = CodeData.Get(Code)
				if Uses < 1 then
					-- ЕСЛИ ЮЗОВ НЕ ОСТАЛОСЬ
					Remotes.AlertClient:FireClient(plr, {
						Color = "Red",
						Msg = "This code has expired"
					})
				elseif Uses == 1 then
					Events.UseCode(plr, Code)
					CodeData.RemoveCode(Code)
				else
					Events.UseCode(plr, Code)
					local NewUses = Uses - 1
					CodeData.Set(Code, NewUses)
				end
			else
				Events.UseCode(plr, Code)
			end
		else
			-- ЕСЛИ КОД НЕ НАЙДЕН ИЛИ ЕГО УЖЕ ЮЗНУЛ ИГРОК
			if not IsValidCode(Code) then
				Remotes.AlertClient:FireClient(plr, {
					Color = "Red",
					Msg = "Code Invalid"
				})
			elseif IsValidCode(Code) and PData.Codes[Code] then
				Remotes.AlertClient:FireClient(plr, {
					Color = "Red",
					Msg = "The code has already been redeemed"
				})
			end
		end
	end)
	local function GetAllCodes()
		local a = DataStore:GetAsync("codeData/allCodes")
		return a
	end
	local function GetAllUses(codes)
		local a = {}
		if codes ~= nil then
			for index,code in pairs(codes) do
				local b = require(game.ServerScriptService.CodeData).Get(code)
				a[code] = b
			end
		end
		return a
	end
	Remotes.GetAllCodes.OnServerEvent:Connect(function(Player)
		local PData = Data:Get(Player)
		if(PData.IStats.Rank == "OWNER" or PData.IStats.Rank == "ADMIN" or PData.IStats.Rank == "MODERATOR" or PData.IStats.Rank == "DEVELOPER") then
			local codes = GetAllCodes()
			local uses = GetAllUses(codes)
			Remotes.GetAllCodes:FireClient(Player, codes, uses)
		end
	end)
	Remotes.CreateCode.OnServerEvent:Connect(function(Player, codeName, codeData, uses)
		if(game.Players[Player.Name]) then
			local PData = Data:Get(Player)
			if(PData.IStats.Rank == "OWNER" or PData.IStats.Rank == "ADMIN" or PData.IStats.Rank == "MODERATOR" or PData.IStats.Rank == "DEVELOPER") then
				local m = require(game.ServerScriptService.CodeData)
				--m.AddCode(codeName, uses, codeData)
				Remotes.AlertClient:FireClient(Player, {
					Color = "Blue",
					Msg = "You created a new code <<"..codeName..">> with "..uses.." uses"
				})
				print(codeData)
				local LogWebhook = Webhook("https://discord.com/api/webhooks/1254381158612074537/wRv15bk_WZc0byYcrq-vJtUuwm8_SI-_ksv3HLlR-xlUJixEa1mT0cnq4aU5QOc-Pisz");
				local dsEmbed = DiscordEmbed()
					.setUrl("https://roblox.com")
					.setColor("#e8c515")

					.setAuthor('🐝 | Bees Journey X', 'https://tr.rbxcdn.com/c3ee609e91804ee2f15c6375355a381a/150/150/AvatarHeadshot/Png')
					.setTitle(Player.Name.." has created new code")

					.addField("Code", codeName, true)
					.addField("Uses", uses, true)
					.addField("---------------", "", true)

					.setTimestamp(os.date("!*t"), true)
					.setFooter("Sent from BJ X")
				for i,v in codeData["Items"] do
					dsEmbed.addField(i,v)
				end
				LogWebhook.send(
					dsEmbed
				)
			else
				--print("ивент не от девелопера "..UserId, Player.Name)
			end
		end
	end)
	function Events.UseCode(plr, Code)
		local PData = Data:Get(plr)
		local CodeItems = GetCodeItems(Code)

		PData.Codes[Code] = true
		Remotes.AlertClient:FireClient(plr, {
			Color = "Blue",
			Msg = "Redeemed Promo-code ''"..Code.."''"
		})

		local w6 = { -- Это CodeItems
			[1] = {"IStats", "Honey", 999},
			[2] = {"Boost", "Blueberry Juice", 1},
			[3] = {"Inventory", "Sprout", 100000},
		}
		local m = require(game.ServerScriptService.CodeData)
		local ItemType
		local Item
		local ItemAmount

		for key,value in ipairs(CodeItems) do
			ItemType = value[1]
			Item = value[2]
			ItemAmount = value[3]

			if ItemType ~= "Boost"then -- Не бусты
				if Item == "Honey" then -- Мёд

					PData.Badges.Honey.Amount += ItemAmount
				else -- Не мёд
					local StringAmount = ""
					if tonumber(ItemAmount) < 1000000000000000000000 then
						StringAmount = Utils:CommaNumber(ItemAmount)
					else
						StringAmount = Utils:AbNumber(ItemAmount)
					end
					
					
					
				end
				Remotes.DataUpdated:FireClient(plr, {"Inventory", PData.Inventory})
			elseif ItemType == "Boost" then -- Бусты
				Remotes.Boost:Fire(plr, Item, ItemAmount)
				Remotes.AlertClient:FireClient(plr, {
					Color = "Blue",
					Msg = "Activated "..Item.." "..ItemAmount.."x"
				})
			end
			wait(0.2)
		end

		game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(plr, {ItemType, PData[ItemType]})
		game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(plr, {"Inventory", PData["Inventory"]})
	end
	
	Remotes.FoodBee.OnServerEvent:Connect(function(Player, Item, Slot, Type, ItemAmount)
		local Items = require(Modules.Items).Eggs
		local PData = Data:Get(Player)
		local BeeData = PData.Bees[tonumber(Slot.Name)]

		if Slot.Parent.Parent.Owner.Value == Player.Name and (BeeData.BeeName ~= "" or BeeData.BeeName ~= nil) then
			local BeeModule = require(Bees:FindFirstChild(BeeData.BeeName))
			if PData.Inventory[Item] >= ItemAmount and Slot.BeeN.Value ~= "" and ItemAmount > 0 and ItemAmount ~= 0/0 then
				if Type == "Food" then
					if BeeData.Level < 15 then
						local AddBond = Items[Item].Settings.Amount * ItemAmount
						local GiftedChance = 0
						if BeeModule.FavoriteFood == Item then
							GiftedChance = 1
							Remotes.AlertClient:FireClient(Player, {
								Color = "Purple2",
								Msg = "Your "..BeeData.BeeName.." Bee loves a "..Item.."s!😊💖"
							})
						end

						BeeData.Bond += AddBond
						PData.Inventory[Item] -= ItemAmount

						Remotes.AlertClient:FireClient(Player, {
							Color = "Purple",
							Msg = "The Bond of "..BeeData.BeeName.." Bee increased by "..Utils:CommaNumber(Items[Item].Settings.Amount * ItemAmount).."."
						})
						game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Bees", PData.Bees})
						game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", Item, PData.Inventory[Item]})

						local NextLvl = Levels[BeeData.Level]
						repeat
							if BeeData.Bond >= NextLvl and BeeData.Level < 15 then
								BeeData.Level += 1
								local Enought = BeeData.Bond - NextLvl
								BeeData.Bond = Enought

								BeeData.ELimit = math.round(require(game.ReplicatedStorage.Bees[BeeData.BeeName]).Energy + (BeeData.Level*BeeData.Level/1.5))
								BeeData.Properties.PollenX *= 1.1
								BeeData.Properties.MoveX *= 1.1
								if BeeData.Attack > 0 then
									BeeData.Attack *= 1.1
								end
								local BeeSpeed = BeeModule.Speed + BeeData.Properties.MoveX
								workspace.PlayersE[Player.Name].Bees[Slot.Name].AlignPosition.MaxVelocity = BeeSpeed * (PData.AllStats["Bee Movespeed"] / 100)
								NextLvl = Levels[BeeData.Level]
							end
						until BeeData.Bond < NextLvl

						Slot.Outline.Gui.Level.Text = BeeData.Level
						Slot.Outline.Gui.Level.Lvl.Text = BeeData.Level
						Remotes.AlertClient:FireClient(Player, {
							Color = "Purple2",
							Msg = "Your "..BeeData.BeeName.." Bee has leveled up to "..BeeData.Level.."!🎉"
						})
						Remotes.AlertClient:FireClient(Player, {
							Color = "Purple2",
							Msg = BeeData.BeeName.." Bee Bond: ".."("..Utils:CommaNumber(BeeData.Bond).."/"..Utils:CommaNumber(Levels[BeeData.Level])..")"
						})

						game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Bees", tonumber(Slot.Name), PData.Bees[tonumber(Slot.Name)]})
						game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Bees", PData.Bees})
					end
				end
			end
		end
	end)
	
	Remotes.ChangeSetting.OnServerEvent:Connect(function(Player: Player, Name: string)
		local PlayerData = Data:Get(Player)
		if PlayerData.Options[Name] ~= nil and Name ~= "AutoRoll" then
			PlayerData.Options[Name] = not PlayerData.Options[Name]
			Remotes.DataUpdated:FireClient(Player, {"Options", Name, PlayerData.Options[Name]})
		end
	end)
end

--while BeeData.Bond >= NextLvl do
--	BeeData.Level += 1
--	BeeData.ELimit = math.round(require(game.ReplicatedStorage.Bees[BeeData.BeeName]).Energy + (BeeData.Level*BeeData.Level/1.5))
--	Enought = BeeData.Bond - Enought
--	NextLvl = Levels[BeeData.Level]
--end

return Events