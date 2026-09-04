local M = {}
local diagnostic_float_win
local show_diagnostic_float = true

local function format_buffer(bufnr)
    local clients = vim.lsp.get_clients({
        bufnr = bufnr,
        method = "textDocument/formatting",
    })
    local client = vim.iter(clients):find(function(candidate)
        return candidate.name == "eslint"
    end) or clients[1]

    if client then
        vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
    end
end

-- Lsp Keymaps --
local lsp_keymaps = function(bufnr)
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)
    vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)
    vim.keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)
    vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)

    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    -- Selects a code action available at the current cursor position
    vim.keymap.set({"n", "x"}, "<leader>c", "<cmd>FzfLua lsp_code_actions<CR>", opts)
    vim.keymap.set("n", "<leader>q", "<cmd>FzfLua lsp_document_diagnostics<CR>", opts)
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

    local lsp_augroup = vim.api.nvim_create_augroup("LspConfig", { clear = true })

    -- Show diagnostics in a floating window on hover (CursorHold)
    vim.api.nvim_create_autocmd("CursorHold", {
        group = lsp_augroup,
        callback = function()
            if show_diagnostic_float then
                local _, winid = vim.diagnostic.open_float({ focus = false, scope = "cursor" })
                diagnostic_float_win = winid
            end
        end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_augroup,
        callback = function(args)
            if vim.g.format_on_save then
                format_buffer(args.buf)
            end
        end,
    })

    vim.keymap.set("n", "<leader>d", function()
        show_diagnostic_float = not show_diagnostic_float
        vim.notify("Diagnostic hover popups " .. (show_diagnostic_float and "enabled" or "disabled"))

        if
            not show_diagnostic_float
            and diagnostic_float_win
            and vim.api.nvim_win_is_valid(diagnostic_float_win)
        then
            vim.api.nvim_win_close(diagnostic_float_win, true)
        end
    end, { desc = "Toggle diagnostic hover popups", silent = true })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_augroup,
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
                M.on_attach(client, args.buf)
            end
        end,
    })
end

-- On Attach --
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    if client:supports_method("textDocument/inlayHint", bufnr) then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

return M
