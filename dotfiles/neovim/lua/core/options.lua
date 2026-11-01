local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.updatetime = 250

opt.splitright = true
opt.splitbelow = true

opt.undofile = true
opt.swapfile = false

-- Treesitter folding; files open unfolded (zM fold all, zR unfold all, za toggle)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "" -- show the folded line itself, syntax-highlighted
opt.foldlevel = 99
