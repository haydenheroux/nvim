local function basedpyright()
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

	return {
		on_attach = function()
			vim.keymap.set("n", "<leader>tt", toggle_type_checking_mode)
		end,
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = off_mode,
				},
			},
		},
	}
end

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
			autoformat = false,
		},
		config = function()
			local lspconfig = require("lspconfig")
			local masonlsp = require("mason-lspconfig")

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

			-- vim.api.nvim_create_augroup("__formatter__", { clear = true })
			-- vim.api.nvim_create_autocmd("BufWritePost", {
			-- 	group = "__formatter__",
			-- 	command = ":FormatWrite",
			-- })

			masonlsp.setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local settings = {
				basedpyright = basedpyright(),
			}

			for _, name in ipairs(masonlsp.get_installed_servers()) do
				if settings[name] then
					lspconfig[name].setup({
						capabilities = capabilities,
						on_attach = settings[name].on_attach,
						settings = settings[name].settings,
					})
				else
					lspconfig[name].setup({
						capabilities = capabilities,
					})
				end
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
