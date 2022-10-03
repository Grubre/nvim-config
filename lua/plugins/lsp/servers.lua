local config = require("plugins.lsp.config")
config.setup()
local on_attach = config.on_attach
local lsp_flags = config.flags

local lspconfig = require("lspconfig")
local capabilities = config.capabilities

require("clangd_extensions").setup({
    server = {
        cmd = {
            "clangd",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--background-index",
        },
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        init_options = {
            clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
        },
    },
})
lspconfig["pyright"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
})
lspconfig["sumneko_lua"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "use" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})
lspconfig["rust_analyzer"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

--CMAKE
lspconfig["cmake"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
})
