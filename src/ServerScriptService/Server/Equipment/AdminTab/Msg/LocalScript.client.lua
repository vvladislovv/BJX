script.Parent.Enter.MouseButton1Click:Connect(function()
	local announce = script.Parent.Parent.TextBox.Text
	if announce ~= "" then
		if game.ReplicatedStorage.IfSend.Value == false then
			script.Parent.Parent.TextBox.Text = ""
			game.ReplicatedStorage.Send:FireServer(announce)
		else
			script.Parent.Text = "Cannot Send Now"
			wait(1)
			script.Parent.Text = "Reedem"
		end
	else
		script.Parent.Text = "Error"
		wait(1)
		script.Parent.Text = "Reedem"
	end
end)