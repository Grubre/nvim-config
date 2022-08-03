local mason_loaded, mason  = pcall(require,"mason")
if not mason_loaded then
    vim.notify("Mason failed to load!")
    return
end
local mason_lspconfig_loaded, mason_lspconfig  = pcall(require,"mason-lspconfig")
if not mason_lspconfig_loaded then
    vim.notify("Mason-lspconfig failed to load!")
    return
end


mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
mason_lspconfig.setup()
