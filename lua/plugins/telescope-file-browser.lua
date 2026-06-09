return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
	    require("telescope").setup({
		extensions = {
			depth = 2,
			auto_depth = true,
			file_browser = {
				display_stat = {
					size = false,
					mode = false
				}
			}
		}
	    })
	    vim.keymap.set("n", "<space>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Telescope file explorer" })
    end,
}
