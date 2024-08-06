return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mfussenegger/nvim-lint",
			"mhartington/formatter.nvim",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = "shut-up",
				keymap = {
					jump_to_mark = "<C-space>",
					manual_complete = "",
				},
			}
		end,
		config = function()
			local lspconfig = require("lspconfig")
			local masonlsp = require("mason-lspconfig")

			require("mason").setup()

			require("formatter").setup({
				filetype = {
					cpp = {
						require("formatter.filetypes.cpp").clangformat,
					},
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

			local coq = require("coq")

			for _, name in ipairs(masonlsp.get_installed_servers()) do
				lspconfig[name].setup(coq.lsp_ensure_capabilities({}))
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				---@diagnostic disable-next-line: unused-local
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
