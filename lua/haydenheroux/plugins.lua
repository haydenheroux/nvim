local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    {
        'hrsh7th/nvim-cmp',
        -- event = 'InsertEnter',
        event = 'VeryLazy',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-omni',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',

        },
        config = function()
            require('haydenheroux.config.cmp')
        end,
    },

    {
        'neovim/nvim-lspconfig',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            require('haydenheroux.config.lsp')
        end,
    },

    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'gopls',
                'lua-language-server',
            }
        }
    },
    'williamboman/mason-lspconfig.nvim',

    {
        'mfussenegger/nvim-jdtls',
        ft = { 'java' }
    },

    'MunifTanjim/prettier.nvim',

    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        build = ':TSUpdate',
        config = function()
            require('haydenheroux.config.treesitter')
        end,
    },

    {
        'tpope/vim-fugitive',
        enable = true,
        config = function()
            require('haydenheroux.config.fugitive')
        end,
    },

    { 'tpope/vim-commentary',        event = 'VeryLazy' },

    {
        'airblade/vim-gitgutter',
        config = function()
            require('haydenheroux.config.gitgutter')
        end
    },

    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope.nvim', config = function()
        require('haydenheroux.config.telescope')
    end },

    { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' },

    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        config = function()
            require('haydenheroux.config.lualine')
        end,
    },

    {
        'Mofiqul/dracula.nvim',
    },

    {
        "catppuccin/nvim",
    },

    {
        'sdiehl/vim-ormolu',
        config = function()
            -- TODO use Lua
            vim.cmd [[
                let g:ormolu_command='fourmolu'
                let g:ormolu_options=['--no-cabal']
            ]]
        end,
        ft = { 'haskell' }
    },

    {
        'vimwiki/vimwiki',
        event = 'VeryLazy'
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            require('haydenheroux.config.harpoon')
        end,
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here
        end
    }
}
