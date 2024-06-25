local deb = false
script.Parent.MouseButton1Click:Connect(function()
	if deb == false then
		deb = true
		local Item = script.Parent.Item
		game.ReplicatedStorage.Remotes.CreateBeeSlot:FireServer(Item.Value, script.Parent.Slot.Value)
		wait(0.3)
		deb = false
	end
end)