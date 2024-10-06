local options = {
    cmdheight = 1,              -- sets the bottom command bar height to be 1
    relativenumber = true,      -- the numbers on the left are relative to cursor
    smartcase = true,           -- smartcase for searching
    smarttab = true,            -- smarttab for indentation
    expandtab = true,           -- inserts spaces instead of tab
    tabstop = 4,                -- tab = 4 spaces
    shiftwidth = 0,             -- shiftwidth = 0 <=> shiftwidth = tabstop
    cindent = true,             -- indenting based on cindent rules
    cinkeys = "0{,0},0),0],9#,!^F,o,O,e",
    mouse = "a",                -- enables mouse
    laststatus = 1,             -- adds a status line only if there at least two windows
    swapfile = false,           -- disables the swapfile
    splitbelow = true,          -- splits to the bottom
    splitright = true,          -- splits to the right
    scrolloff = 8,              -- keeps 8 rows at the bottom and top of the screen if possible
    sidescrolloff = 8,          -- keeps 8 columns to the left and right if possible
    cursorline = true,          -- higlights the cursor line
    numberwidth = 4,            -- minimum number of columns used for line numbers
    updatetime = 100,           -- increased update time (default 4000)
    hlsearch = true,            -- highlights all matches
    ignorecase = true,          -- ignores the case when searching
    signcolumn = "yes",         -- always displays the sign column
    completeopt = { "menu", "menuone", "noselect" },
    autoread = true,            -- when file was changed outside of nvim, read it again
    clipboard = "unnamedplus",  -- uses external clipboard provider
    number = true,              -- shows the current number line (the rest are relative)
    inccommand = "nosplit",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.filetype.add({ extension = { fs = 'glsl' }})
vim.filetype.add({ extension = { vs = 'glsl' }})

-- Automatically refresh file changes after entering a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, { pattern = "*", command = "checktime" })

vim.opt.shortmess:append("c")

-- stop 'o' from adding a comment
vim.opt.formatoptions:remove "o"

vim.opt.whichwrap:append("h,l,<,>,[,],b,s")

vim.opt.termguicolors = true
vim.cmd.colorscheme('catppuccin')

vim.wo.foldmethod = 'expr'
vim.wo.fen = false
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
