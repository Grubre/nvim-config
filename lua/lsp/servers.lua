-- C++ -> Clangd
vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--log=error",
        "--completion-style=bundled",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--background-index",
    },
})

-- lua -> lua_ls
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
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

-- rust -> rust_analyzer
vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            files = { watcher = "server" },
            cargo = {
                features = "all",
            },
            check = {
                command = "clippy",
                features = "all",
            },
            inlayHints = {
                bindingModeHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
            },
        },
    },
})

-- verilog -> verible
vim.lsp.config("verible", {
    cmd = { "verible-verilog-ls", "--rules_config_search", "--indentation_spaces=4", "--file_list_path", "verible.filelist" },
})

vim.lsp.enable({
    "clangd",
    "lua_ls",
    "pyright",
    "ols",
    "rust_analyzer",
    "verible",
    "ts_ls",
    "tailwindcss",
    "eslint",
    "html",
    "cssls",
    "jsonls",
})
