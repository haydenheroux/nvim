local standard = "standard"
local strict = "strict"

local type_checking_mode = standard

local function toggle_type_checking_mode(basedpyright)
	if type_checking_mode == strict then
		type_checking_mode = standard
	else
		type_checking_mode = strict
	end

	local settings = basedpyright.config.settings

    settings.basedpyright.analysis.typeCheckingMode = type_checking_mode

    vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = settings })
end

return {
	on_attach = function(basedpyright)
		vim.keymap.set("n", "<leader>tt", function ()
		  toggle_type_checking_mode(basedpyright)
		end)
	end,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = standard,
			},
		},
	},
}
