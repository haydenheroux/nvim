-- Setup nvim-cmp.
local cmp = require("cmp")

local kind_icons = {
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
    Color = "󰏘", -- TODO
    File = "󰈙", -- TODO
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup {
    snippet = {
        expand = function(args)
            -- For `vsnip` users.
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        -- TODO Ctrl + J / Ctrl + K
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
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-e>"] = cmp.mapping.abort(),
    },
    sources = {
        { name = "nvim_lsp" },               -- For nvim-lsp
        { name = "vsnip" },                  -- For `vsnip` users.
        { name = "path" },                   -- for path completion
        -- { name = "buffer",  keyword_length = 2 }, -- for buffer word completion
        { name = "emoji",   insert = true }, -- emoji completion
    },
    completion = {
        keyword_length = 1,
        completeopt = "menu,noselect",
    },
    view = {
        entries = "custom",
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    },
}

vim.cmd([[
	" text
	" gray
	highlight! CmpItemKindText guibg=NONE guifg=#F8F8F2
	" functions
	" green
	highlight! CmpItemKindMethod guibg=NONE guifg=#50FA7B
	highlight! link CmpItemKindFunction CmpItemKindMethod
	highlight! link CmpItemKindConstructor CmpItemKindMethod
	highlight! link CmpItemKindEnumMember CmpItemKindMethod
	" variables
	" purple
	highlight! CmpItemKindField guibg=NONE guifg=#BD93F9
	highlight! link CmpItemKindVariable CmpItemKindField
	highlight! link CmpItemKindProperty CmpItemKindField
	highlight! link CmpItemKindValue CmpItemKindField
	" structures
	" orange
	highlight! CmpItemKindClass guibg=NONE guifg=#FFB86C
	highlight! link CmpItemKindInterface CmpItemKindClass
	highlight! link CmpItemKindModule CmpItemKindClass
	highlight! link CmpItemKindEnum CmpItemKindClass
	" other
	highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#44475A
	highlight! CmpItemAbbrMatch guibg=NONE guifg=#8BE9FD
	highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
]])
