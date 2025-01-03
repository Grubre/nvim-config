vim.loader.enable()
vim.g.mapleader = "\\"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
-- Set up lazy, and load `lua/plugins/` directory
require("lazy").setup({ import = "plugins" }, {
    defaults = {lazy = true},
    change_detection = {
        notify = false,
    },
})

require('options')
require('keymaps')
require('lsp')
