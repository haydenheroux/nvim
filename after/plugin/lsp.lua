local lsp = require('lsp-zero').preset("lsp-only")

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	local builtin = require('telescope.builtin')

	vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>d", builtin.lsp_definitions, opts)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>i", builtin.lsp_implementations, opts)
	vim.keymap.set("n", "<leader>r", builtin.lsp_references, opts)
	vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
end)

lsp.set_sign_icons({
	error = "",
	warn = "",
	hint = "",
	info = ""
})

lsp.setup()
