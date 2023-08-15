vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Actions",
    callback = function(event)
        local opts = { buffer = true, remap = false }

        local builtin = require('telescope.builtin')

        vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>d", builtin.lsp_definitions, opts)
        vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>i", builtin.lsp_implementations, opts)
        vim.keymap.set("n", "<leader>re", builtin.lsp_references, opts)
        vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
    end
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "gopls",
        "lua_ls"
    }
})

local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local get_servers = require('mason-lspconfig').get_installed_servers

for _, server_name in ipairs(get_servers()) do
    lspconfig[server_name].setup({
        capabilities = lsp_capabilities,
    })
end
