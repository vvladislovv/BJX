game.ReplicatedStorage.Remotes.SSound.OnClientEvent:Connect(function(Type, Speed, Play)
	if Play then
		
		--if Type == "MolyCricketStomp" then
		--end
		
	script[Type].PlaybackSpeed = Speed
	script[Type]:Play()
	else
		script[Type]:Stop()
	end
end)

