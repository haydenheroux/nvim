function SetGitGutterColor()
    vim.cmd [[ highlight GitGutterAdd guifg=#50fa7b ]]
    vim.cmd [[ highlight GitGutterChange guifg=#8be9fd ]]
    vim.cmd [[ highlight GitGutterDelete guifg=#ff5555 ]]
end

SetGitGutterColor()
