local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Collect "..StAm.."/"..NdAm.." Tokens from "..Info.Res.."."
end

return module
