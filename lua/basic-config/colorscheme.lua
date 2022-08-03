--=================================--
--COLORSCHEME
--=================================--
vim.opt.termguicolors=true
local colorscheme = "kanagawa"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

local border_color = '#dcd7ba'

--vim.api.nvim_set_hl(0, 'NormalFloat', {bg='none'})
--vim.api.nvim_set_hl(0, 'FloatBorder', {fg=border_color, bg='none'})
vim.api.nvim_set_hl(0, 'TelescopeBorder', {fg=border_color})

