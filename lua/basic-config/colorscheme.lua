--=================================--
--COLORSCHEME
--=================================--
vim.opt.termguicolors = true

-- oled interation
-- require("catppuccin").setup {
--     color_overrides = {
--         mocha = {
--             base = "#000000",
--             mantle = "#000000",
--             crust = "#000000",
--         }
--     }
-- }

local colorscheme = "moonfly"

if vim.fn.has("win32") == 1 then
    colorscheme = "tokyonight"
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

local border_color = "#dcd7ba"

--vim.api.nvim_set_hl(0, 'NormalFloat', {bg='none'})
--vim.api.nvim_set_hl(0, 'FloatBorder', {fg=border_color, bg='none'})
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_color })

if colorscheme == 'moonfly' then
    vim.cmd('hi Normal guibg=0')
end

vim.opt.termguicolors = true
