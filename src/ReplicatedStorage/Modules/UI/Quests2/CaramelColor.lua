local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Collect "..StAm.."/"..NdAm.." Caramel from " ..Info.NColor.." Flowers."
end

return module
