return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mfussenegger/nvim-lint",
			"mhartington/formatter.nvim",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local masonlsp = require("mason-lspconfig")

			require("mason").setup()

			require("formatter").setup({
				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
				},
			})

			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd
			augroup("__formatter__", { clear = true })
			autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWrite",
			})

			masonlsp.setup()

			for _, name in ipairs(masonlsp.get_installed_servers()) do
				lspconfig[name].setup({})
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local options = { buffer = true, remap = false }

					vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_next, options)
					vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_prev, options)
					vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, options)
					vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, options)
					vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, options)

					local builtin = require("telescope.builtin")
					vim.keymap.set("n", "<leader>i", builtin.lsp_implementations, options)
					vim.keymap.set("n", "<leader>rf", builtin.lsp_references, options)
					vim.keymap.set("n", "<leader>d", builtin.lsp_definitions, options)
				end,
			})
		end,
	},
}
