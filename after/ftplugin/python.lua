local on_mode = "strict"
local off_mode = "standard"

local type_checking_mode = off_mode

local function toggle_type_checking_mode()
	if type_checking_mode == on_mode then
		type_checking_mode = off_mode
	else
		type_checking_mode = on_mode
	end

	local new_settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = type_checking_mode,
			},
		},
	}

	-- TODO Hacky way around using buf_notify
	-- https://github.com/chrisgrieser/.config/blob/306e8ba9774c8277ecc4ed655040e0091ccda50b/nvim/lua/plugins/lsp-servers.lua#L317-L329
	-- vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = new_settings })
	require("lspconfig")["basedpyright"].setup({
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		settings = new_settings,
	})
end

vim.keymap.set("n", "<leader>tt", toggle_type_checking_mode)
