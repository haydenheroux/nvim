function SetGitGutterColor()
    vim.cmd [[ highlight GitGutterAdd guifg=#50fa7b guibg=#282a36 ]]
    vim.cmd [[ highlight GitGutterChange guifg=#8be9fd guibg=#282a36 ]]
    vim.cmd [[ highlight GitGutterDelete guifg=#ff5555 guibg=#282a36 ]]
end

SetGitGutterColor()
