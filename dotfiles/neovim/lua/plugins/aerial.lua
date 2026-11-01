-- Outline sidebar: functions/methods/types of the current file
return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "AerialToggle", "AerialNavToggle" },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
  },
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
    layout = { default_direction = "prefer_right", min_width = 30 },
    show_guides = true,
  },
}
