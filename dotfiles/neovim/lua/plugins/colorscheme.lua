return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- load before other plugins so highlight groups exist
  opts = {
    flavour = "mocha",
    transparent_background = true,
    integrations = {
      cmp = false,
      blink_cmp = true,
      gitsigns = true,
      telescope = true,
      neotree = true,
      which_key = true,
      treesitter = true,
    },
    styles = {
      conditionals = {}
    }
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
