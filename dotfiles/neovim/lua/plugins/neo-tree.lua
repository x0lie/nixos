return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
  },
  init = function()
    -- Open neo-tree instead of netrw on 'nvim <dir>'
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
      once = true,
      callback = function()
        local stats = vim.uv.fs_stat(vim.fn.expand("%"))
        if stats and stats.type == "directory" then
          require("neo-tree")
        end
      end,
    })

    -- Auto-quit when only neo-tree remains
    vim.api.nvim_create_autocmd("QuitPre", {
      group = vim.api.nvim_create_augroup("NeoTreeQuitWithLastWindow", { clear = true }),
      callback = function()
        local wins = vim.api.nvim_list_wins()
        local tree_wins = {}
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("neo%-tree") then
            table.insert(tree_wins, w)
          end
        end
        if #tree_wins > 0 and #tree_wins == #wins - 1 then
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_default",
    },
  },
}
