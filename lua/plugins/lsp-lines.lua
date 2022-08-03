local lsp_lines_loaded, lsp_lines = pcall(require,"lsp_lines")
if not lsp_lines_loaded then
    vim.notify("Lsp Lines failed to load!")
    return
end
lsp_lines.setup()
