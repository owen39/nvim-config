return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable("gopls")
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({})
		end,
	},
}
