local indent_blankline_loaded, indent_blankline = pcall(require, "ibl")
if not indent_blankline_loaded then
	vim.notify("Indent_blankline failed to load!")
	return
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

indent_blankline.setup({
    scope = {
        show_start = false
    }
})

-- {
-- 	space_char_blankline = " ",
-- 	show_trailing_blankline_indent = false,
-- 	show_current_context = true,
-- }
