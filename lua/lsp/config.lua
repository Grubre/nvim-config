local M = {}

-- Lsp Keymaps --
local lsp_keymaps = function(bufnr)
    local opts = { buffer = true, noremap = true, silent = true }

    vim.keymap.set("n", "gd", FzfLua.lsp_definitions, opts)
    vim.keymap.set("n", "gi", FzfLua.lsp_implementations, opts)
    vim.keymap.set("n", "gt", FzfLua.lsp_typedefs, opts)
    vim.keymap.set("n", "gr", FzfLua.lsp_references, opts)

    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "cd", vim.lsp.buf.rename, opts)
    -- -- Selects a code action available at the current cursor position
    vim.keymap.set({"n", "x"}, "<leader>c", FzfLua.lsp_code_actions, opts)
    vim.keymap.set("n", "<leader>q", FzfLua.lsp_document_diagnostics , opts)
end

M.setup = function()
    local config = {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
        },
        -- disable virtual text
        virtual_text = false,
        update_in_insert = false,
        --underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

-- Capabilities --
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

M.capabilites = capabilites

-- On Attach --
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    vim.lsp.inlay_hint.enable()
    require "lsp_signature".on_attach({}, bufnr)
end

-- Lsp Flags --
M.lsp_flags = {}

return M
