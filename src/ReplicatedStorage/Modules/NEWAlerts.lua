local Alerts = {}; do
	local TweenService = game:GetService("TweenService")
	local CSer = game:GetService("TextChatService")
	local Player = game.Players.LocalPlayer
	local UI = Player.PlayerGui:WaitForChild("UI")
	local Frame = UI.Alerts
	local Utils = require(game.ReplicatedStorage.Modules.Utils)
	local Items = require(game.ReplicatedStorage.Modules.Items)
	local Colors = {
		["Red"] = Color3.fromRGB(222, 30, 30),
		["Blue"] = Color3.fromRGB(81, 143, 197),
		["Pink"] = Color3.fromRGB(255, 105, 243),
	}
	local ActiveNotifications = {}
	local LifeTime = 5

	local function GetFromByText(Text: string)
		return string.split(Text, "(")[2]:gsub(".", {["("] = "", [")"] = ""})
	end

	local function GetNotificationByItem(Item: string, Type: string, Text: string)
		for ItemName, Data in ActiveNotifications do
			if ItemName == string.format("%s [%s]%s", Item, Type, string.find(Text, "from") and string.format(" (%s)", GetFromByText(Text)) or "") then
				--if ItemName == Item and Data.Type == Type then
				return Data
			end
		end
		return nil
	end

	function Alerts.Alert(Data: {Msg: string?, Color: string, Item: string?})
		local NotificationFrame = nil
		local NotificationData = Data.Item and GetNotificationByItem(Data.Item, string.find(Data.Msg, "+") and "+" or "-", Data.Msg)
		if NotificationData then
			NotificationFrame = NotificationData.Frame
			NotificationFrame.Size = UDim2.fromOffset(0,0)
			NotificationData.SpawnedAt = os.time()
			NotificationData.Amount = NotificationData.Amount + string.gsub(Data.Msg, "%D", "")
			NotificationFrame.Text = string.format("%s%s %s%s %s", NotificationData.Type, NotificationData.Amount, Data.Item, (NotificationData.Amount ~= 1 and Data.Item ~= "Honey") and "s" or "", NotificationData.From and string.format("(%s)", NotificationData.From) or "")
			NotificationFrame.LayoutOrder = 999
		else
			NotificationFrame = script.Template:Clone()
			NotificationFrame.BackgroundColor3 = Colors[Data.Color] or Colors["Blue"]
			NotificationFrame.Text = Data.Msg
			NotificationFrame.Size = UDim2.fromOffset(0,0)
			NotificationFrame.Visible = true
			NotificationFrame.Parent = Frame
			NotificationFrame.ImageLabel.Visible = Data.Item ~= nil
			if Data.Item ~= nil then
				NotificationFrame.ImageLabel.Image = Data.Item == "Honey" and "rbxassetid://15028813852" or (Items.Eggs[Data.Item] and Items.Eggs[Data.Item].Image or "")
			end

			if Data.Item then
				local Type = string.find(Data.Msg, "+") and "+" or "-"
				ActiveNotifications[string.format("%s [%s]%s", Data.Item, Type, string.find(Data.Msg, "from") and string.format(" (%s)", GetFromByText(Data.Msg)) or "" )] = {
					Frame = NotificationFrame,
					SpawnedAt = os.time(),
					Amount = string.gsub(Data.Msg, "%D", ""),
					Type = string.find(Data.Msg, "+") and "+" or "-",
					From = string.find(Data.Msg, "()") and GetFromByText(Data.Msg) or nil,
				}
				NotificationData = ActiveNotifications[string.format("%s [%s]%s", Data.Item, Type, string.find(Data.Msg, "from") and string.format(" (%s)", GetFromByText(Data.Msg)) or "" )]
			end
		end

		TweenService:Create(NotificationFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = script.Template.Size
		}):Play()

		task.delay(LifeTime + 0.2, function()
			if (Data.Item and NotificationData and os.time() - NotificationData.SpawnedAt >= LifeTime) or (not Data.Item) then
				if Data.Item then
					ActiveNotifications[string.format("%s [%s]%s", Data.Item, string.find(Data.Msg, "+") and "+" or "-", string.find(Data.Msg, "from") and string.format(" (%s)", GetFromByText(Data.Msg)) or "" )] = nil
					--table.remove(ActiveNotifications, string.format("%s [%s]", Data.Item, string.find(Data.Msg, "+") and "+" or "-"))
				end
				TweenService:Create(NotificationFrame, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
					Size = UDim2.fromOffset(0,0)
				}):Play()
				task.wait(0.1)
				NotificationFrame:Destroy()
			end 
		end)
		
		if Data.Chat then
			game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(string.format('<font size="15"><font color="#1aafff"><b>[ %s%s %s ]</b></font></font>', string.find(Data.Msg, "-") and "-" or "+", Utils:AbNumber(string.gsub(Data.Msg, "%D", "")), Data.Item and Data.Item or "Item"))
		end
	end
end

return Alerts