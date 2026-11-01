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
      nix = { "nixfmt" },
    },
    -- Go convention is to always format on save; other filetypes stay manual
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == "go" then
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end
    end,
  },
}
