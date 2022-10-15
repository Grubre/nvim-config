require("basic-config.colorscheme")

require("plugins.plugins")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.mason")
require("plugins.lualine")
require("plugins.treesitter")
require("plugins.indent-blankline")
require("plugins.telescope")
require("plugins.dressing")
require("plugins.toggleterm")
require("plugins.gitsgins")
require("plugins.toggleterm")
require("plugins.autopairs")
require("plugins.project-nvim")
require("plugins.comment")
require("plugins.dap")
require("plugins.nvim-cmake")
require("plugins.templater")
if vim.fn.has("win32") == 0 then -- Doesnt work on windows because packer has problem creating directories with names of these plugins (one is from gitlab and the other(?))
    require("plugins.nvim-window")
    require("plugins.lsp-lines")
end

require("basic-config.keymaps")
require("basic-config.neovide")

require("basic-config.options")
require("plugins.leap")
