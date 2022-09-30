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
--lspconfig['clangd'].setup{
--on_attach = on_attach,
--flags = lsp_flags,
--capabilities = capabilities,
--}
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
local rust_opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "(",
            other_hints_prefix = ")",
        },
        on_initialized = function(_)
            vim.notify("Rust initialized!")
        end,
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                diagnostic = {
                    messageDelay = 200,
                },
            },
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        },
        standalone = false,
    },
}
require("rust-tools").setup(rust_opts)

--CMAKE
lspconfig["cmake"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
})
