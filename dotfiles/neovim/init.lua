vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.lazy")

-- lazy.nvim auto-imports every spec file under lua/plugins/*.lua
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
