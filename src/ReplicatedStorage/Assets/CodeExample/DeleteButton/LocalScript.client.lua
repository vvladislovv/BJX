script.Parent.MouseButton1Click:Connect(function()
    local code = script.Parent.Parent.CodeName.Text
    script.Parent.Parent:Remove()
    game.ReplicatedStorage.Remotes.RemoveCode:FireServer(code)
end)