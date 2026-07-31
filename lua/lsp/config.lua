local M = {}

-- Lsp Keymaps --
local lsp_keymaps = function(bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", FzfLua.lsp_definitions, opts)
    vim.keymap.set("n", "gi", FzfLua.lsp_implementations, opts)
    vim.keymap.set("n", "gt", FzfLua.lsp_typedefs, opts)
    vim.keymap.set("n", "gr", FzfLua.lsp_references, opts)

    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    -- Selects a code action available at the current cursor position
    vim.keymap.set({"n", "x"}, "<leader>c", FzfLua.lsp_code_actions, opts)
    vim.keymap.set("n", "<leader>q", FzfLua.lsp_document_diagnostics , opts)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
    end, opts)
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
        },
        -- Disable virtual text
        virtual_text = false,
        update_in_insert = false,
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

    -- Show diagnostics in a floating window on hover (CursorHold)
    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
            if vim.g.show_diagnostic_float ~= false then
                vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
            end
        end,
    })
end

-- Capabilities --
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

M.capabilities = capabilities

local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- On Attach --
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    if client:supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = formatting_augroup,
            buffer = bufnr,
            callback = function()
                if vim.g.format_on_save == true then
                    vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                end
            end,
        })
    end
    require "lsp_signature".on_attach({}, bufnr)
end

-- Lsp Flags --
M.flags = {}

return M
