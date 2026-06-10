local function set_defaults() 
	vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ff9e64' })
	vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#7aa2f7' })	
end

return {
	{ 
		"folke/tokyonight.nvim", 
		enabled = false, 
		config = function()
			require('tokyonight').setup({
				on_colors = function(c)
					c.bg = '#000000'
				end,
			})
			vim.cmd.colorscheme "tokyonight"
			set_defaults()
		end
	},
	{ 
		'projekt0n/github-nvim-theme', 
		name = 'github-theme',   
		enabled = false,
		config = function()
			require('github-theme').setup({
			})

			vim.cmd('colorscheme github_dark')
		end,
	},
	{
		"rockyzhang24/arctic.nvim",
		enabled = false,
		dependencies = { "rktjmp/lush.nvim" },
		name = "arctic",
		branch = "main",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme arctic")
			set_defaults()
		end
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		version = "*",
		config = function()
			require("kanagawa").setup({
				colors = {
					theme = {
						dragon = {
							ui = {
								bg = "#000000",
							},
						},
					},
				},
			})
			vim.cmd.colorscheme("kanagawa-dragon")
			set_defaults()
		end,
	},
	{
		"catppuccin/nvim", 
		enabled = false, 
		name = "catppuccin", 
		priority = 1000,
		config = function() 
			vim.cmd.colorscheme "catppuccin-nvim"
			set_defaults()
		end,
	},
	{
		"Mofiqul/vscode.nvim", 
		enabled = true, 
		config = function()
			require('vscode').setup({
				color_overrides = {
					vscBack = "#000000"
				}
			})
			vim.cmd.colorscheme "vscode"
			set_defaults()
		end,

	},
	{
		"askfiy/visual_studio_code",
		enabled = false,
		config = function()
			vim.cmd([[colorscheme visual_studio_code]])
			set_defaults()
		end,
	},
}
