local indent_blankline_loaded, indent_blankline  = pcall(require,"indent_blankline")
if not indent_blankline_loaded then
    vim.notify("Indent_blankline failed to load!")
    return
end


vim.opt.list = true
vim.opt.listchars:append("space:⋅")

indent_blankline.setup {
    space_char_blankline = " ",
    show_trailing_blankline_indent = false,
    show_current_context = true
}
