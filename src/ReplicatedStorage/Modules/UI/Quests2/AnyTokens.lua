local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Collect "..StAm.."/"..NdAm.." Tokens."
end

return module
