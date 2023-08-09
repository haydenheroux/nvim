vim.opt.number = true
vim.opt.relativenumber = true

local tabstop = 4
vim.opt.tabstop = tabstop
vim.opt.shiftwidth = tabstop
vim.opt.softtabstop = tabstop
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = ">-" }

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
