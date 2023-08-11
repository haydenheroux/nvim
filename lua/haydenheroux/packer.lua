vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'


    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "Mofiqul/dracula.nvim",
        as = "dracula",
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'

    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-tree/nvim-web-devicons'
        }
    }

    use 'mfussenegger/nvim-jdtls'

    use 'nathom/filetype.nvim'
end)
