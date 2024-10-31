return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mfussenegger/nvim-lint",
			"mhartington/formatter.nvim",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		opts = {
			autoformat = true,
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("mason").setup()

			require("formatter").setup({
				filetype = {
					c = {
						require("formatter.filetypes.cpp").clangformat,
					},
					cpp = {
						require("formatter.filetypes.cpp").clangformat,
					},
					go = {
						require("formatter.filetypes.go").gofmt,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					python = {
						require("formatter.filetypes.python").black,
					},
					haskell = {
						require("formatter.filetypes.haskell").ormolu,
					},
				},
			})

			vim.api.nvim_create_augroup("__formatter__", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWrite",
			})

			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local configs = {
				basedpyright = require("lsp.basedpyright"),
				clangd = require("lsp.clangd"),
				jdtls = require("lsp.jdtls"),
				lua_ls = require("lsp.lua_ls"),
			}

			for lsp, config in pairs(configs) do
				config.capabilities = capabilities
				lspconfig[lsp].setup(config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				---@diagnostic disable-next-line: unused-local
				callback = function(event)
					local options = { buffer = true, remap = false }

					vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_next, options)
					vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_prev, options)
					vim.keymap.set("n", "<leader>..", vim.lsp.buf.code_action, options)
					vim.keymap.set("n", "<leader>.f", vim.lsp.buf.format, options)
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
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			local lsp_lines = require("lsp_lines")

			lsp_lines.setup()

			local enable = function()
				vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				lsp_lines_enabled = true
			end

			local disable = function()
				vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				lsp_lines_enabled = false
			end

			local toggle = function()
				if lsp_lines_enabled then
					disable()
				else
					enable()
				end
			end

			disable()

			vim.keymap.set("", "<leader>;", toggle)
		end,
	},
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^4",
		lazy = false,
	},
}
