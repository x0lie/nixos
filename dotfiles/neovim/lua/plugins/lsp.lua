return {
  "neovim/nvim-lspconfig", -- provides default per-server configs consumed by vim.lsp.config
  dependencies = { "saghen/blink.cmp" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = vim.keymap.set
        local opts = { buffer = event.buf }

        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "gy", vim.lsp.buf.type_definition, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Add more servers here as needed
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- Points nixd at this flake's evaluated options so completion sees real
    -- option names from nixosConfigurations.main, not just bare nixpkgs.
    local configDir = "/home/x0lie/Projects/nixos"
    vim.lsp.config("nixd", {
      capabilities = capabilities,
      settings = {
        nixd = {
          nixpkgs = {
            expr = 'import (builtins.getFlake "' .. configDir .. '").inputs.nixpkgs { }',
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake "' .. configDir .. '").nixosConfigurations.main.options',
            },
            ["home-manager"] = {
              expr = '(builtins.getFlake "'
                .. configDir
                .. '").nixosConfigurations.main.options.home-manager.users.type.getSubOptions []',
            },
          },
        },
      },
    })

    vim.lsp.enable({ "lua_ls", "nixd" })
  end,
}
