local config = require("lsp.config")
config.setup()
local on_attach = config.on_attach
local lsp_flags = config.flags
local capabilities = config.capabilities

-- C++ -> Clangd
vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--completion-style=bundled",
        "--cross-file-rename",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--background-index",
        "--compile-commands-dir=build/debug"
    },
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
})

-- lua -> lua_ls
vim.lsp.config("lua_ls", {
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
vim.lsp.config("pyright", {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
})

-- -- rust -> rust_analyzer

-- verilog -> verible
vim.lsp.config("verible", {
  cmd = { "verible-verilog-ls", "--rules_config_search", "--indentation_spaces=4", "--file_list_path", "verible.filelist" },
})

-- odin -> ols
vim.lsp.config("ols", {})

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ols")
