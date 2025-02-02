local icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
	Copilot = "",
}

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"kdheepak/cmp-latex-symbols",
			"micangl/cmp-vimtex",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "latex_symbols", option = { strategy = 1 } },
					{ name = "vimtex" },
					{ name = "copilot" },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						ellipsis_char = "…",
						show_labelDetails = true,
						symbol_map = icons,
					}),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			-- text: gray
			vim.cmd("highlight! CmpItemKindText guibg=NONE guifg=#CAD3F5")
			-- function: green
			vim.cmd("highlight! CmpItemKindMethod guibg=NONE guifg=#A6DA95")
			vim.cmd("highlight! link CmpItemKindFunction CmpItemKindMethod")
			vim.cmd("highlight! link CmpItemKindConstructor CmpItemKindMethod")
			vim.cmd("highlight! link CmpItemKindEnumMember CmpItemKindMethod")
			-- variable: purple
			vim.cmd("highlight! CmpItemKindField guibg=NONE guifg=#C6A0F6")
			vim.cmd("highlight! link CmpItemKindVariable CmpItemKindField")
			vim.cmd("highlight! link CmpItemKindProperty CmpItemKindField")
			vim.cmd("highlight! link CmpItemKindValue CmpItemKindField")
			-- struct: orange
			vim.cmd("highlight! CmpItemKindClass guibg=NONE guifg=#F5A97F")
			vim.cmd("highlight! link CmpItemKindInterface CmpItemKindClass")
			vim.cmd("highlight! link CmpItemKindModule CmpItemKindClass")
			vim.cmd("highlight! link CmpItemKindEnum CmpItemKindClass")
			-- other
			vim.cmd("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#A5ADCB")
			vim.cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=#7DC4E4")
			vim.cmd("highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch")
			vim.cmd("highlight! CmpItemKindCopilot guibg=NONE guifg=#A6dA95")
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enalbed = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
