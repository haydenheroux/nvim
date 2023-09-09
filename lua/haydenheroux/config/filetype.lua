require("filetype").setup({
    overrides = {
        function_extensions = {
            ["ls"] = function ()
                vim.opt.expandtab = false
            end,
            ["tsv"] = function ()
                vim.opt.expandtab = false
            end,
        }
    }
})
