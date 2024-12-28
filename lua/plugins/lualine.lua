local copilot_indicator = function()
    local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
    if client == nil then
	return ""
    end

    if vim.tbl_isempty(client.requests) then
	return ": idle"
    end

    local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    return ": " .. spinners[frame + 1]
end

return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = { 'NvimTree' },
            },
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = { "filename", "diagnostics" },
            lualine_x = { "copilot", "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    }
}
