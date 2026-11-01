return {
  "neovim/nvim-lspconfig", -- provides default per-server configs consumed by vim.lsp.config
  dependencies = { "saghen/blink.cmp" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Neovim's built-in gr* LSP maps (grn, grr, ...) make our `gr` wait for a
    -- possible second key; everything they do is mapped below instead
    for _, lhs in ipairs({ "grn", "grr", "gri", "gra", "grt", "grx" }) do
      pcall(vim.keymap.del, { "n", "x" }, lhs)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = vim.keymap.set
        local opts = { buffer = event.buf }
        local telescope = require("telescope.builtin")

        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gr", telescope.lsp_references, opts)
        map("n", "gy", vim.lsp.buf.type_definition, opts)
        map("n", "gi", telescope.lsp_implementations, opts)
        map("n", "<leader>fs", telescope.lsp_document_symbols, { buffer = event.buf, desc = "Find symbol in file" })
        map(
          "n",
          "<leader>fS",
          telescope.lsp_dynamic_workspace_symbols,
          { buffer = event.buf, desc = "Find symbol in project" }
        )
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>ch", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
        end, { buffer = event.buf, desc = "Toggle inlay hints" })
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

    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      settings = {
        gopls = {
          completeUnimported = true, -- suggest unimported packages and add the import
          usePlaceholders = true, -- fill in function params as tab-able placeholders
          staticcheck = true,
          gofumpt = true,
          analyses = { unusedparams = true, unusedwrite = true, nilness = true },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    vim.lsp.enable({ "lua_ls", "nixd", "gopls" })
  end,
}
