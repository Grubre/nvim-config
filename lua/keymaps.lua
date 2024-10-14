-- ================================================================
-- VANILLA
-- ================================================================

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

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Turn off highlight
vim.keymap.set("n", "<leader>l", ":nohl<CR>")

-- ================================================================
-- LSP
-- ================================================================
local telescope = require("telescope.builtin")
_G.lsp_keymaps = function(bufnr)
    local opts = { buffer = true, noremap = true, silent = true }

    -- Displays hover information about the symbol under the cursor
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    -- or use command
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- Jumps to definition (if there are multiple - lists them)
    vim.keymap.set("n", "gd", function()
        telescope.lsp_definitions()
    end, opts)
    -- Jumps to implementations (if there are multiple - lists them)
    vim.keymap.set("n", "gi", function()
        telescope.lsp_implementations()
    end, opts)
    -- Jumps to type definition (if there are multiple - lists them)
    vim.keymap.set("n", "gt", function()
        telescope.lsp_type_definitions()
    end, opts)
    -- Lists all the references
    vim.keymap.set("n", "gr", function()
        telescope.lsp_references()
    end, opts)
    -- Displays a function's signature information

    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set("n", "cd", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    -- Selects a code action available at the current cursor position
    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("x", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", opts)
    vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- Move to the previous diagnostic
    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    -- Move to the next diagnostic
    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    -- show line diagnostic
    vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    -- show diagnostic list
    vim.keymap.set("n", "<leader>q", function()
        telescope.diagnostics(require("telescope.themes").get_ivy())
    end, opts)
end

-- ================================================================
-- PLUGINS
-- ================================================================

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<c-P>", "<cmd>:Telescope<CR>")
vim.keymap.set("n", "<leader>ee", function()
    require("telescope").extensions.file_browser.file_browser()
end)
vim.keymap.set("n", "<leader>ff", function()
    telescope.find_files()
end)
vim.keymap.set("n", "<c-p>", function()
    telescope.find_files()
end)
vim.keymap.set("n", "g/", function()
    telescope.live_grep()
end)

-- Nvim tree bindings
local nvim_tree_api = require("nvim-tree.api")
local open_tree = function() nvim_tree_api.tree.open({find_file = true, focus = true}) end
vim.keymap.set("n", "<c-t>", open_tree, { silent = true })

-- Nvim window
-- vim.keymap.set("n", "<space>", function() require("nvim-window").pick() end)

-- Zed compatibility
-- make :E command open nvim-tree, use lua function to avoid vimscript
vim.api.nvim_create_user_command("E", open_tree, { nargs = 0})

-- ================================================================
-- MISC
-- ================================================================

-- PROFILING (https://www.reddit.com/r/neovim/comments/17a4m8q/why_is_my_neovim_laggy/), comment in the thread
-- vim.keymap.set("n", "<leader>ups", function()
-- 	vim.cmd([[
-- 		:profile start /tmp/nvim-profile.log
-- 		:profile func *
-- 		:profile file *
-- 	]])
-- end, { desc = "Profile Start" })
--
-- vim.keymap.set("n", "<leader>upe", function()
-- 	vim.cmd([[
-- 		:profile stop
-- 		:e /tmp/nvim-profile.log
-- 	]])
-- end, { desc = "Profile End" })
