return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "File History" },
  },
  opts = {
    enhanced_diff_hl = true,
  },
}

