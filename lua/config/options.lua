-- Put local + mason-managed binaries on PATH so linters and other CLIs resolve
-- regardless of the shell nvim was launched from (prose linters, spell checkers,
-- LanguageTool wrapper, etc.).
local path_sep = vim.loop.os_uname().version:match("Windows") and ";" or ":"
local extra_bins = {
	vim.fs.normalize(vim.env.HOME .. "/.local/bin"),
	vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin"),
}
for _, dir in ipairs(extra_bins) do
	if vim.fn.isdirectory(dir) == 1 then
		vim.env.PATH = dir .. path_sep .. vim.env.PATH
	end
end

-- Fallback Vale style (lua/plugins/lint.lua wires vale into nvim-lint).
-- Any project with its own .vale.ini (discovered upward from the file) overrides
-- this; otherwise Vale falls back to ~/.config/nvim/vale/.vale.ini.
vim.env.VALE_CONFIG_PATH = vim.fs.normalize(vim.env.HOME .. "/.config/nvim/vale/.vale.ini")

vim.opt.number = true
vim.opt.relativenumber = true

local tabstop = 4
vim.opt.tabstop = tabstop
vim.opt.shiftwidth = tabstop
vim.opt.softtabstop = tabstop
vim.opt.expandtab = true

-- vim.opt.list = true
vim.opt.listchars = { tab = ">-" }

vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'nvim %{expand("%:p")}'

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.mouse = ""

vim.opt.spell = true
vim.opt.spelllang = "en_us"
