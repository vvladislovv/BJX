local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Collect "..Info.Token.." Tokens "..StAm.."/"..NdAm.."."
end

return module
