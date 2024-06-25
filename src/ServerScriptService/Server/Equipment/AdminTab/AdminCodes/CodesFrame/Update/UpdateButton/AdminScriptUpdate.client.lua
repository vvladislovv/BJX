script.Parent.MouseButton1Click:Connect(function()
    if(script.Parent.Parent.Parent.Parent.Parent.Parent.Name ~= "Equipment") then
        for i,v in pairs(script.Parent.Parent.Parent.CodesFrame:GetChildren()) do
            if(v.Name ~= "l") then
                v:Remove()
            end
        end
        wait(1)
        game.ReplicatedStorage.Remotes.GetAllCodes:FireServer()
    end
end)