return {
	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				filetype = {
					c = {
						require("formatter.filetypes.cpp").clangformat,
					},
					cpp = {
						require("formatter.filetypes.cpp").clangformat,
					},
					css = {
						require("formatter.filetypes.html").prettier,
					},
					go = {
						require("formatter.filetypes.go").gofmt,
					},
					html = {
						require("formatter.filetypes.html").prettier,
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
					tex = {
						require("formatter.filetypes.tex").latexindent,
					},
					java = {
						require("formatter.filetypes.java").google_java_format,
					},
					typescript = {
						require("formatter.filetypes.typescriptreact").prettierd,
					},
					typescriptreact = {
						require("formatter.filetypes.typescriptreact").prettierd,
					},
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				callback = function(opts)
					local ft = vim.bo[opts.buf].filetype
					if ft == "markdown" or ft == "tex" or ft == "gitcommit" then
						require("lint").try_lint("write_good")
					end
				end,
			})
		end,
	},
}
