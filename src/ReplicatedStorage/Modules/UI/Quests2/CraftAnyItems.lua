local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Craft "..StAm.."/"..NdAm.." Ingredients."
end

return module
