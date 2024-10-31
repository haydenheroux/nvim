return {
	on_attach = function(clangd)
		local tabstop = 2
		vim.opt.tabstop = tabstop
		vim.opt.shiftwidth = tabstop
		vim.opt.softtabstop = tabstop
		vim.opt.expandtab = true
	end,
}
