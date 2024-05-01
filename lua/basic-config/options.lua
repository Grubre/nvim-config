--=================================--
--OPTIONS
--=================================--
local options = {
    cmdheight = 0,
    relativenumber = true,
    smartcase = true,
    smarttab = true,
    expandtab = true,
    tabstop = 4,
    shiftwidth = 4,
    cindent = true,
    cinkeys = "0{,0},0),0],9#,!^F,o,O,e",
    mouse = "a",
    laststatus = 1,
    swapfile = false,
    splitbelow = true,
    splitright = true,
    scrolloff = 8,
    sidescrolloff = 8,
    wrap = false,
    cursorline = true,
    numberwidth = 4,
    updatetime = 100,
    hlsearch = true,
    ignorecase = true,
    signcolumn = "yes",
    completeopt = { "menu", "menuone", "noselect" },
    autoread = true,
    clipboard = "unnamedplus",
    number = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.filetype.add({ extension = { fs = 'glsl' }})
vim.filetype.add({ extension = { vs = 'glsl' }})

-- Automatically refresh file changes after entering a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, { pattern = "*", command = "checktime" })

vim.opt.shortmess:append("c")

vim.opt.whichwrap:append("h,l,<,>,[,],b,s")

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = {"*.rs"},
    callback = function()
       vim.cmd('write')
    end
})
