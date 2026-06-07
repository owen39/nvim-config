return {
    { "folke/tokyonight.nvim", enabled = true, config = function()
        vim.cmd.colorscheme "tokyonight"
        vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ff9e64' })
        vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#7aa2f7' })
    end }
}
