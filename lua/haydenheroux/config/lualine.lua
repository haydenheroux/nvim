require('lualine').setup {
    options = {
        theme = 'catppuccin', -- theme = 'dracula-nvim',
        icons_enabled = true,
        -- Comment these lines to show slants
        component_separators = '',
        section_separators = '',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = {}, -- {'progress'} -- Show % progress thru file
        lualine_z = { 'location' },
    }
}
