return function()
	local config = {
		hook = {
			on_filetype = function()
				local tabstop = 2
				vim.opt.tabstop = tabstop
				vim.opt.shiftwidth = tabstop
				vim.opt.softtabstop = tabstop
				vim.opt.expandtab = true
				-- NOTE The keymap for starting the R terminal is `<localleader>rf`
				vim.keymap.set(
					"n",
					"<Enter>",
					"<Plug>RDSendLine",
					{ desc = "Execute the current line in the R terminal" }
				)
				vim.keymap.set(
					"v",
					"<Enter>",
					"<Plug>RSendSelection",
					{ desc = "Execute the selected lines in the R terminal" }
				)
			end,
		},
		R_args = { "--quiet", "--no-save" },
	}
	-- NOTE Set `R_AUTO_START=true` to automatically start shell
	if vim.env.R_AUTO_START == "true" then
		config.auto_start = "on startup"
		config.objbr_auto_start = true
	end
	require("r").setup(config)
end
