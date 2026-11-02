return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "Format buffer",
    },
  },
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      lua = { "stylua" },
      markdown = { "prettier" },
      nix = { "nixfmt" },
    },
    -- Go convention is to always format on save; markdown does too to keep tables aligned;
    -- other filetypes stay manual
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      if ft == "go" then
        return { timeout_ms = 1000, lsp_format = "fallback" }
      elseif ft == "markdown" then
        -- prettier is slower to start than gofumpt
        return { timeout_ms = 3000 }
      end
    end,
  },
}
