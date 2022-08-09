local comment_loaded, comment = pcall(require,'Comment')
if not comment_loaded then
    vim.notify("Comment failed to load!")
    return
end
comment.setup()
