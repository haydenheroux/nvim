require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "haskell" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

local install = require 'nvim-treesitter.install'

install.compilers = { "clang" }
install.prefer_git = true
