local Classes = script.Classes;
local DiscordEmbed = require(Classes.Embed);
local Webhook = require(Classes.WebhookClient);

local JoinLeaveWebhook = Webhook("https://discord.com/api/webhooks/1254377145564659752/KqICVSqkhnPQJ6ywkvGwAlatNVFViId_asKeYODmSv_Fd7WnAVrRF748MWn0ZqrdLDqX");
local AdminWebhook = Webhook("https://discord.com/api/webhooks/1254362274949500989/7iNIAl3AQnpx2uWQ-KeLiDFgib4VB_rDyNE2eeSG9jarbmdNpC0rRmb62fdEvzMXCUka");

--AdminWebhook.send(
--	DiscordEmbed()
--		.setUrl("https://roblox.com")
--		.setColor("#ffaa00")

--		.setAuthor('🐝 | Bees Journey X', 'https://tr.rbxcdn.com/c3ee609e91804ee2f15c6375355a381a/150/150/AvatarHeadshot/Png')
--		.setTitle("Test Webhook Message")
--		.setDescription('from the game')


--		.addField("Release", "soon", true)

--		.setThumbnail('')
--		.setImage('https://tr.rbxcdn.com/3b250cbff41a4b25b562a654c44314d8/768/432/Image/Webp')

--		.setTimestamp(os.date("!*t"), true)
--		.setFooter("Sent from BJ X")

--)

game.Players.PlayerAdded:Connect(function(player: Player)
	wait(1)
	local PData = require(game.ServerScriptService.Server.Data):Get(player);
	if(PData.IStats.Playtime < 10) then
		JoinLeaveWebhook.send(
			DiscordEmbed()
				.setUrl("https://roblox.com")
				.setColor("#8de815")

				.setAuthor('🐝 | Bees Journey X', 'https://tr.rbxcdn.com/c3ee609e91804ee2f15c6375355a381a/150/150/AvatarHeadshot/Png')
				.setTitle("New Player has joined into the game!")


				.addField("Name", player.Name, true)
				.addField("Display Name", player.DisplayName, true)
				.addField("User Id", player.UserId, true)
				.addField("Playtime", PData.IStats.Playtime, true)


				.setTimestamp(os.date("!*t"), true)
				.setFooter("Sent from BJ X")

		)
	end
end)

game.Players.PlayerRemoving:Connect(function(player: Player)
	wait(1)
	local PData = require(game.ServerScriptService.Server.Data):Get(player);
	if(PData.IStats.Playtime < 10) then
		JoinLeaveWebhook.send(
			DiscordEmbed()
				.setUrl("https://roblox.com")
				.setColor("#e81515")

				.setAuthor('🐝 | Bees Journey X', 'https://tr.rbxcdn.com/c3ee609e91804ee2f15c6375355a381a/150/150/AvatarHeadshot/Png')
				.setTitle("New Player has leaved from the game =(")


				.addField("Name", player.Name, true)
				.addField("Display Name", player.DisplayName, true)
				.addField("User Id", player.UserId, true)
				.addField("Playtime", PData.IStats.Playtime, true)
				.addField("Honey", PData.IStats.Honey, true)


				.setTimestamp(os.date("!*t"), true)
				.setFooter("Sent from BJ X")

		)
	end
end)