require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
      },
      winbar = {
          lualine_a = {'filename'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'filetype'},
      },
      inactive_winbar = {
          lualine_a = {'filename'},
          lualine_b = {'diagnostics'},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'filetype'},

      },
      extensions = {}
})
