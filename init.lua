-- OPTIONS --
vim.g.mapleader = "\\"
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.numberwidth = 4
vim.o.swapfile = false
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
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.shortmess:append("c")
vim.o.cindent = true
vim.o.cinkeys = "0{,0},0),0],9#,!^F,o,0,e"
vim.o.updatetime = 0
vim.opt.whichwrap:append("h,l,<,>,[,],b,s")
vim.opt.termguicolors = true
vim.opt.list = true

vim.opt.indentkeys:remove(":")

-- PACKAGE MANAGER --
vim.pack.add({
    -- colorschemes --
    {src = "https://github.com/rebelot/kanagawa.nvim"},
    {src = "https://github.com/AlexvZyl/nordic.nvim"},
    {src = "https://github.com/bluz71/vim-nightfly-colors"},

    -- lsp plugins --
    {src = "https://github.com/neovim/nvim-lspconfig"},
    {src = "https://github.com/ray-x/lsp_signature.nvim"},

    -- oil plugins --
    {src = "https://github.com/stevearc/oil.nvim"},
    {src = "https://github.com/refractalize/oil-git-status.nvim"},

    -- treesitter plugins --
    {src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main"},
    {src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main"},

    -- mini plugins --
    {src = "https://github.com/nvim-mini/mini.align"},
    {src = "https://github.com/nvim-mini/mini.ai"},
    {src = "https://github.com/nvim-mini/mini.icons"},
    {src = "https://github.com/nvim-mini/mini.surround"},

    -- other plugins --
    {src = "https://github.com/ibhagwan/fzf-lua"},
    {src = "https://github.com/yorickpeterse/nvim-window"},
    {src = "https://github.com/nvim-mini/mini.pairs"},
})

-- Gitsigns configures itself from its plugin script, so keep it off the
-- runtime path until that script should run.
vim.pack.add({
    {src = "https://github.com/lewis6991/gitsigns.nvim"},
}, { load = function() end })

local function after_startup(callback)
    vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
            vim.defer_fn(callback, 10)
        end,
    })
end

after_startup(function()
    vim.cmd.packadd("gitsigns.nvim")
end)

-- MINI PLUGINS SETUP --
after_startup(function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.icons').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
end)

-- COLORSCHEME --
vim.cmd.colorscheme("nightfly")

-- OIL CONFIG --
local oil_api

local function setup_oil()
    if oil_api then
        return
    end

    oil_api = require("oil")
    oil_api.setup({
        default_file_explorer = true,
        win_options = {
            signcolumn = "yes:2",
        },
    })
    require("oil-git-status").setup()
end

local function open_oil()
    setup_oil()
    oil_api.open()
end

vim.api.nvim_create_user_command("E", open_oil, {nargs = 0})

if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    setup_oil()
else
    after_startup(setup_oil)
end

-- FZF LUA CONFIG --
after_startup(function()
    require("fzf-lua").setup()
    FzfLua.register_ui_select()
end)

-- OTHER PLUGINS CONFIG --
require("nvim-window").setup({chars = {'1', '2', '3', '4', '5', '6', '7', '8', '9' }})
-- Signature help is only needed after an LSP attaches.
vim.api.nvim_create_autocmd("LspAttach", {
    once = true,
    callback = function()
        require("lsp_signature").setup()
    end,
})

-- KEYMAPS --
local opts = { silent = true }
-- general keymaps
vim.keymap.set("n", "<leader>l", ":nohl<CR>", opts)
vim.keymap.set("n", "<space>", require("nvim-window").pick, opts)
-- oil keymaps
vim.keymap.set("n", "<leader>e", open_oil, opts)
-- fzf-lua keymaps
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<CR>", opts)
vim.keymap.set("n", "g/", "<cmd>FzfLua live_grep<CR>", opts)
vim.keymap.set("v", "g/", "<cmd>FzfLua grep_visual<CR>", opts)
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<CR>", opts)
vim.keymap.set("n", "<leader>s", function()
    if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/documentSymbol" }) == 0 then
        vim.notify("No LSP document-symbol provider is attached to this buffer", vim.log.levels.WARN)
        return
    end

    vim.cmd.FzfLua("lsp_document_symbols")
end, { silent = true, desc = "Document symbols" })
vim.keymap.set("n", "<leader>w", "<cmd>FzfLua builtin<CR>", opts)
vim.keymap.set("n", "<leader>j", function()
    vim.g.format_on_save = not vim.g.format_on_save
    vim.notify("Format on save: "..tostring(vim.g.format_on_save))
end)

-- TREESITTER CONFIG --
local function start_treesitter(buf)
    if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
        return
    end

    -- Disable Treesitter for files larger than 1MB
    local max_filesize = 1 * 1024 * 1024
    local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
    if stats and stats.size > max_filesize then
        return
    end

    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
    if lang and vim.treesitter.language.add(lang) and vim.treesitter.query.get(lang, "highlights") then
        vim.treesitter.start(buf, lang)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local buf = args.buf
        -- C/C++ highlight queries are expensive to compile. Let startup draw
        -- its first screen with regex highlighting, then enable Treesitter.
        if vim.v.vim_did_enter == 0 then
            vim.defer_fn(function() start_treesitter(buf) end, 100)
        else
            start_treesitter(buf)
        end
    end,
})

-- Automatically install common parsers if they are missing
local parsers = { "lua", "vim", "vimdoc", "markdown", "rust", "bash", "typescript", "tsx", "html", "css", "json", "c", "cpp" }
local treesitter = require("nvim-treesitter")
local installed_parsers = treesitter.get_installed("parsers")
local missing_parsers = {}
for _, parser in ipairs(parsers) do
    if not vim.list_contains(installed_parsers, parser) then
        table.insert(missing_parsers, parser)
    end
end
if #missing_parsers > 0 then
    treesitter.install(missing_parsers)
end

local function setup_treesitter_textobjects()
    require("nvim-treesitter-textobjects").setup({
        move = {
            set_jumps = true,
        },
    })

    local ts_move = require("nvim-treesitter-textobjects.move")

    local function map_ts_move(lhs, method, query, desc)
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
            ts_move[method](query, "textobjects")
        end, { silent = true, desc = desc })
    end

    -- Function/method motions.
    map_ts_move("]m", "goto_next_start", "@function.outer", "Next function start")
    map_ts_move("[m", "goto_previous_start", "@function.outer", "Previous function start")
    map_ts_move("]M", "goto_next_end", "@function.outer", "Current/next function end")
    map_ts_move("[M", "goto_previous_end", "@function.outer", "Previous function end")

    -- Class-like motions. In Rust this includes structs, enums, traits, impls, and modules.
    map_ts_move("]]", "goto_next_start", "@class.outer", "Next class-like block start")
    map_ts_move("[[", "goto_previous_start", "@class.outer", "Previous class-like block start")
    map_ts_move("][", "goto_next_end", "@class.outer", "Current/next class-like block end")
    map_ts_move("[]", "goto_previous_end", "@class.outer", "Previous class-like block end")

    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- Keep native f/F/t/T character motions repeatable after overriding ; and ,.
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
end

after_startup(setup_treesitter_textobjects)

require("lsp")
