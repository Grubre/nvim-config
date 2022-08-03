local bufferline_loaded, bufferline = pcall(require, "bufferline")
if not bufferline_loaded then
    vim.notify("Bufferline failed to load!")
    return
end
bufferline.setup()
