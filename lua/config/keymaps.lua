vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("n", "<C-s>", "<C-w>s", { desc = "Horizontally split pane" })
vim.keymap.set("n", "<C-v>", "<C-w>v", { desc = "Vertically split pane" })
vim.keymap.set("n", "<C-c>", vim.cmd.bd, { desc = "Close buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move cursor to left pane" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move cursor to below pane" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move cursor to above pane" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move cursor to right pane" })

vim.keymap.set("n", "zj", "]s", { desc = "Jump to next misspelled word" })
vim.keymap.set("n", "zk", "[s", { desc = "Jump to previous misspelled word" })
vim.keymap.set("n", "zi", "zg", { desc = "Ignore misspelled word" })
vim.keymap.set("n", "zc", "z=", { desc = "Correct misspelled word" })
