local config = require("lsp.config")
config.setup()
local on_attach = config.on_attach
local lsp_flags = config.flags

local lspconfig = require("lspconfig")
local capabilities = config.capabilities

capabilities.offsetEncoding = { "utf-16" } -- fixes a bug where on each keystroke in input mode an error pops up

-- C++ -> clangd
require("clangd_extensions").setup()
require("lspconfig").clangd.setup({
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
})

-- lua -> lua_ls
lspconfig["lua_ls"].setup({
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

-- python -> pyright
lspconfig["pyright"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
})

-- rust -> rust_analyzer
local rt = require("rust-tools")
rt.setup({
    server = {
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    allFeatures = true,
                    overrideCommand = {
                        'cargo', 'clippy', '--workspace', '--message-format=json',
                        '--all-targets', '--all-features'
                    }
                }
            }
        },
    }
})

-- verilog -> verible
require('lspconfig').verible.setup {
  cmd = { "verible-verilog-ls", "--rules_config_search", "--indentation_spaces=4", "--file_list_path", "verible.filelist" },
}
