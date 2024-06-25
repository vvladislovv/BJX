local module = {}

function module.Get(Label, StAm, NdAm, Info)
	if Info.TokenType then
		Label.Text = "Collect "..Info.TokenType.." Tokens "..StAm.."/"..NdAm.."."
	end
	if Info.TokenColor then
		Label.Text = "Collect "..Info.TokenColor.." Ability Tokens "..StAm.."/"..NdAm.."."
	end
end

return module
