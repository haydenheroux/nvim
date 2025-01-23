local cmp = require("cmp")
local config = cmp.get_config()
for _, source in pairs(config.sources) do
	if source.name == "latex_symbols" then
		source.option = {
			-- Strategy 2: Show and insert the LaTeX command
			strategy = 2,
		}
		break
	end
end
cmp.setup(config)
