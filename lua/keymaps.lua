-- Map 'alt+j/l' to move the line up or down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Map 'alt+<up>/<down>' to move the line up or down
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")

-- Nvim tree bindings
local nvim_tree_api = require("nvim-tree.api")
local open_tree = function() nvim_tree_api.tree.open({find_file = true, focus = true}) end
vim.keymap.set("n", "<c-t>", open_tree, { silent = true })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Nvim window
vim.keymap.set("n", "<space>", function()
    require("nvim-window").pick()
end, opts)

-- Zed compatibility
-- make :E command open nvim-tree, use lua function to avoid vimscript
vim.api.nvim_create_user_command("E", open_tree, { nargs = 0})
