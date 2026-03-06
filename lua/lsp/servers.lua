local config = require("lsp.config")
config.setup()
local on_attach = config.on_attach
local lsp_flags = config.flags
local capabilities = config.capabilities

-- Helper to setup common options
local default_config = {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-- C++ -> Clangd
vim.lsp.config("clangd", vim.tbl_deep_extend("force", default_config, {
    cmd = {
        "clangd",
        "--completion-style=bundled",
        "--cross-file-rename",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--background-index",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
}))

-- lua -> lua_ls
vim.lsp.config("lua_ls", vim.tbl_deep_extend("force", default_config, {
    filetypes = { "lua" },
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
}))

-- python -> pyright
vim.lsp.config("pyright", vim.tbl_deep_extend("force", default_config, {
    filetypes = { "python" },
}))

-- rust -> rust_analyzer
vim.lsp.config("rust_analyzer", vim.tbl_deep_extend("force", default_config, {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },
            -- This combination is the most robust for rust-analyzer
            checkOnSave = true,
            check = {
                command = "clippy",
                allFeatures = true,
                extraArgs = { "--no-deps" },
            },
            procMacro = {
                enable = true,
            },
            diagnostics = {
                enable = true,
            }
        },
    },
}))

-- verilog -> verible
vim.lsp.config("verible", vim.tbl_deep_extend("force", default_config, {
    cmd = { "verible-verilog-ls", "--rules_config_search", "--indentation_spaces=4", "--file_list_path", "verible.filelist" },
    filetypes = { "verilog", "systemverilog" },
}))

-- odin -> ols
vim.lsp.config("ols", vim.tbl_deep_extend("force", default_config, {
    filetypes = { "odin" },
}))

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ols")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("verible")
