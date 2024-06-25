wait(10)
for i,v in pairs(script.Parent.List:GetChildren()) do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			for k,g in pairs(script.Parent:GetChildren()) do
				if script.Parent.List:FindFirstChild(g.Name) and script.Parent.List:FindFirstChild(g.Name):IsA("TextButton") then
					if g.Name ~= v.Name then
						g:TweenPosition(UDim2.new(0.5,0,2,0), "Out", "Back", 0.5, true)
						spawn(function()
							wait(0.5)
							g.Visible = false
						end)
					end
				end
			end
			spawn(function()
				--wait(0.5)
				script.Parent:FindFirstChild(v.Name).Visible = true
				script.Parent:FindFirstChild(v.Name):TweenPosition(UDim2.new(0.5,0,0.5,0), "Out", "Back", 0.5, true)
			end)
		end)
	end
end

for k,g in pairs(script.Parent:GetChildren()) do
	if script.Parent.List:FindFirstChild(g.Name) then
		if g:FindFirstChild("Back") then
			g.Back.MouseButton1Click:Connect(function()
				for k,g in pairs(script.Parent:GetChildren()) do
					if script.Parent.List:FindFirstChild(g.Name) and script.Parent.List:FindFirstChild(g.Name):IsA("TextButton") then
						g:TweenPosition(UDim2.new(0.5,0,2,0), "Out", "Back", 0.5, true)
					end
				end
			end)
		end
	end
end