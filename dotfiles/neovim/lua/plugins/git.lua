return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local map = vim.keymap.set

        map("n", "]c", function()
          gitsigns.nav_hunk("next")
        end, { buffer = bufnr, desc = "Next git hunk" })
        map("n", "[c", function()
          gitsigns.nav_hunk("prev")
        end, { buffer = bufnr, desc = "Previous git hunk" })

        map("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        map("n", "<leader>hb", gitsigns.blame_line, { buffer = bufnr, desc = "Blame line" })
      end,
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
      })

      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { desc = "Open lazygit" })
    end,
  },
}
