return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- main branch doesn't support lazy-loading
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.install({
      "lua",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "nix",
      "vim",
      "vimdoc",
      "bash",
      "markdown",
      "markdown_inline",
      "json",
      "yaml",
      "toml",
    })

    local function start(buf, lang)
      if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      if vim.treesitter.query.get(lang, "indents") then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    -- main only installs parsers, so enable highlight/indent per buffer here.
    -- Missing parsers are fetched on first use (replaces master's auto_install).
    local available = ts.get_available()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match)
        if not lang then
          return
        end
        if vim.list_contains(ts.get_installed(), lang) then
          start(event.buf, lang)
        elseif vim.list_contains(available, lang) then
          ts.install(lang):await(function(err)
            if not err then
              vim.schedule(function()
                start(event.buf, lang)
              end)
            end
          end)
        end
      end,
    })
  end,
}
