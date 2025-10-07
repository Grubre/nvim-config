-- OPTIONS --
vim.loader.enable()
vim.g.mapleader = "\\"
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.numberwidth = 4
vim.o.swapfile = false
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.hlsearch = true
vim.o.signcolumn = "auto:2"
vim.o.winborder = "rounded"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.laststatus = 1
vim.o.mouse = "a"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")
vim.o.cindent = true
vim.o.cinkeys = "0{,0},0),0],9#,!^F,o,0,e"
vim.o.updatetime = 0
vim.opt.whichwrap:append("h,l,<,>,[,],b,s")
vim.opt.termguicolors = true
vim.opt.list = true

-- PACKAGE MANAGER --
vim.pack.add({
    -- colorschemes --
    {src = "https://github.com/rebelot/kanagawa.nvim"},

    -- lsp plugins --
    {src = "https://github.com/neovim/nvim-lspconfig"},
    {src = "https://github.com/ray-x/lsp_signature.nvim"},

    -- oil plugins --
    {src = "https://github.com/stevearc/oil.nvim"},
    {src = "https://github.com/benomahony/oil-git.nvim"},
    -- other plugins --
    {src = "https://github.com/nvim-mini/mini.icons"},
    {src = "https://github.com/ibhagwan/fzf-lua"},
    {src = "https://github.com/yorickpeterse/nvim-window"},
    {src = "https://github.com/windwp/nvim-autopairs"},
})

-- COLORSCHEME --
vim.cmd.colorscheme("kanagawa")

-- OIL CONFIG --
local oil_api = require("oil")
oil_api.setup({
    default_file_explorer = true
})
local open_oil = function() oil_api.open() end
vim.api.nvim_create_user_command("E", open_oil, {nargs = 0})

-- FZF LUA CONFIG --
require("fzf-lua").setup()
FzfLua.register_ui_select()

-- OTHER PLUGINS CONFIG --
require("mini.icons").setup()
require("nvim-window").setup({chars = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }})
require("nvim-autopairs").setup({fast_wrap = {}})
require("lsp_signature").setup()
require("oil-git").setup()

-- KEYMAPS --
local opts = { silent = true }
-- general keymaps
vim.keymap.set("n", "<leader>l", ":nohl<CR>", opts)
vim.keymap.set("n", "<space>", require("nvim-window").pick, opts)
-- oil keymaps
vim.keymap.set("n", "<leader>e", open_oil, opts)
-- fzf-lua keymaps
vim.keymap.set("n", "<leader>g", FzfLua.live_grep, opts)
vim.keymap.set("n", "g/", FzfLua.live_grep, opts)
vim.keymap.set("v", "g/", FzfLua.grep_visual, opts)
vim.keymap.set("n", "<leader>f", FzfLua.files, opts)

require("lsp")
