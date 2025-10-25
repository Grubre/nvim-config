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
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.signcolumn = "yes"
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
    {src = "https://github.com/AlexvZyl/nordic.nvim"},
    {src = "https://github.com/bluz71/vim-nightfly-colors"},

    -- lsp plugins --
    {src = "https://github.com/neovim/nvim-lspconfig"},
    {src = "https://github.com/ray-x/lsp_signature.nvim"},
    {src = "https://github.com/simrat39/rust-tools.nvim"},

    -- oil plugins --
    {src = "https://github.com/stevearc/oil.nvim"},
    {src = "https://github.com/benomahony/oil-git.nvim"},

    -- other plugins --
    {src = "https://github.com/nvim-mini/mini.icons"},
    {src = "https://github.com/ibhagwan/fzf-lua"},
    {src = "https://github.com/yorickpeterse/nvim-window"},
    {src = "https://github.com/windwp/nvim-autopairs"},
    {src = "https://github.com/nvim-treesitter/nvim-treesitter"},
})

-- COLORSCHEME --
vim.cmd.colorscheme("nightfly")

-- TRESITTER CONFIG --
require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 1 * 1024 * 1024 -- 1MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = true,
    },
}
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
require("nvim-window").setup({chars = {'1', '2', '3', '4', '5', '6', '7', '8', '9' }})
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
vim.keymap.set("n", "<leader>j", function()
    vim.g.format_on_save = not vim.g.format_on_save
    vim.notify("Format on save: "..tostring(vim.g.format_on_save))
end)

require("lsp")
