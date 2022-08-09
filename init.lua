require('basic-config.options')
require('basic-config.colorscheme')

require('plugins.plugins')
require('plugins.cmp')
require('plugins.lsp')
require('plugins.mason')
require('plugins.lualine')
require('plugins.treesitter')
require('plugins.indent-blankline')
require('plugins.telescope')
require('plugins.dressing')
require('plugins.toggleterm')
require('plugins.gitsgins')
require('plugins.toggleterm')
require('plugins.autopairs')
if not vim.fn.has("win32") then
    require('plugins.lsp-lines')
    require('plugins.nvim-window')
end
require('plugins.bufferline')
require('plugins.project-nvim')
require('plugins.comment')
require('plugins.dap')
require('plugins.nvim-cmake')

require('basic-config.keymaps')

if vim.fn.exists("g:neovide") then
    vim.g["neovide_refresh_rate"] = 144
    vim.o.guifont='Hack NF'
end
