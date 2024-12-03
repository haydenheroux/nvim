vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<C-s>", "<C-w>s")
vim.keymap.set("n", "<C-v>", "<C-w>v")
vim.keymap.set("n", "<C-c>", vim.cmd.bd)

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.keymap.set("n", "zj", "]s")
vim.keymap.set("n", "zk", "[s")
vim.keymap.set("n", "zi", "zg")
vim.keymap.set("n", "zc", "z=")
