--=================================--
--KEYMAPS--
--=================================--
-- Unmap s--
vim.keymap.set('n', 's', '<Nop>')
vim.keymap.set('x', 's', '<Nop>')

-- Map 'alt+j/l' to move the line up or down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv')

-- Map 'alt+<up>/<down>' to move the line up or down
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-Down>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-Up>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-Down>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', '<A-Up>', ':m \'<-2<CR>gv=gv')
-- Map 'Control+arrows' to resize windows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- Press jk fast to exit insert mode
vim.keymap.set("i", "jk", "<Esc>")
-- Open netrw
-- Toggle lsp_lines
vim.keymap.set(
    {"n","v"},
    "<Leader>sl",
    require("lsp_lines").toggle,
    { desc = "Toggle lsp_lines" }
)
-- Telescope Keymaps
vim.keymap.set("n", "<c-p>", "<cmd>:Telescope<CR>")

vim.keymap.set("n", "<space>bb", function() require("telescope").extensions.file_browser.file_browser() end)
vim.keymap.set("n", "<space>ee", function() require("telescope").extensions.file_browser.file_browser() end)
vim.keymap.set("n", "<leader>ee", function() require("telescope").extensions.file_browser.file_browser() end)
vim.keymap.set("n", "<space>ff", function() require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end)

vim.keymap.set("n", "<space>gg", function() require("telescope.builtin").live_grep() end)
vim.keymap.set("n", "<leader>gg", function() require("telescope.builtin").live_grep() end)
vim.keymap.set("n", "<space>fb", function() require("telescope.builtin").buffers() end)
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end)
vim.keymap.set("n", "<space>hh", function() require("telescope.builtin").help_tags() end)
vim.keymap.set("n", "<leader>hh", function() require("telescope.builtin").help_tags() end)
vim.keymap.set("n", "<space>cc", function() require("telescope.builtin").commands() end)
vim.keymap.set("n", "<leader>cc", function() require("telescope.builtin").commands() end)

vim.keymap.set("n", "<space>gc", function() require("telescope.builtin").git_commits() end)
vim.keymap.set("n", "<leader>gc", function() require("telescope.builtin").git_commits() end)
vim.keymap.set("n", "<space>gb", function() require("telescope.builtin").git_branches() end)
vim.keymap.set("n", "<leader>gb", function() require("telescope.builtin").git_branches() end)
vim.keymap.set("n", "<space>gs", function() require("telescope.builtin").git_status() end)
vim.keymap.set("n", "<leader>gs", function() require("telescope.builtin").git_status() end)



-- LSP Keymaps
local telescope = require("telescope.builtin")

_G.lsp_keymaps = function(bufnr)
    local opts = { buffer = true, noremap = true, silent = true }

    -- Displays hover information about the symbol under the cursor
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',opts)
    -- or use command
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- Jumps to definition (if there are multiple - lists them)
    vim.keymap.set("n", "gd", function() telescope.lsp_definitions() end, opts)
    -- Jumps to implementations (if there are multiple - lists them)
    vim.keymap.set("n", "gi", function() telescope.lsp_implementations() end, opts)
    -- Jumps to type definition (if there are multiple - lists them)
    vim.keymap.set("n", "gt", function() telescope.lsp_type_definitions() end, opts)
    -- Lists all the references 
    vim.keymap.set('n', 'gr', function() telescope.lsp_references() end,opts)
    -- Displays a function's signature information
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>',opts)
    -- Renames all references to the symbol under the cursor
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>',opts)
    -- Selects a code action available at the current cursor position
    vim.keymap.set('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set('x', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<cr>',opts)
    vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- Move to the previous diagnostic
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>',opts)
    -- Move to the next diagnostic
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>',opts)
    -- show line diagnostic
    vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    -- show diagnostic list
    vim.keymap.set("n", "<leader>q", function() telescope.diagnostics(require('telescope.themes').get_ivy()) end, opts)
end

-- Bufferline Keymaps
vim.keymap.set("n", "<A-Left>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<A-Right>", "<cmd>BufferLineCycleNext<CR>")

-- Search and replace full word (can be repeated with '.')
vim.keymap.set("n", "<leader>sr", ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn")

-- Terminal keymaps
local opts = {noremap = true, silent = true}
vim.keymap.set('n','<c-t>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', opts)
vim.keymap.set('i','<c-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', opts)
vim.keymap.set('n','<leader>tt', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', opts)
vim.keymap.set('i','<leader>tt', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', opts)


vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

vim.api.nvim_create_autocmd("TermEnter", {
    pattern = "term://*toggleterm#*",
    callback = function () vim.keymap.set("t", "<c-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', opts) end
})

vim.keymap.set("n", "<leader>gt", function() _lazygit_toggle() end, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>ht", function() _htop_toggle() end, {noremap = true, silent = true})

-- Debugging
local dap = require("dap")
vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)

-- CPP specific keymaps
-- TO DO (KEYMAPY DO FUNKCJI CLANGD)
vim.api.nvim_create_augroup("CPP_specific",{clear = false})
vim.api.nvim_create_autocmd({"BufEnter", "BufNew"},{
    pattern = "*.cpp,*.hpp",
    callback = function()
        vim.keymap.set("n","<leader>cht", "<cmd>:ClangdTypeHierarchy<CR>", opts)
    end
})







