local toggleterm_loaded, toggleterm  = pcall(require,"toggleterm")
if not toggleterm_loaded then
    vim.notify("Toggleterm failed to load!")
    return
end

toggleterm.setup{
    size = 10,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "rounded",
        width = 100,
        height = 20,
		winblend = 0,
		highlights = {
			Normal = {
                guibg = "#111111"
            },
		},
	},
    winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end
  },
}


local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true,
float_opts = {
    width = 160,
    height = 40
}
})
local htop = Terminal:new({cmd = "htop", hidden = true,
float_opts = {
    width = 160,
    height = 40
}
})

_G._lazygit_toggle = function()
    lazygit:toggle()
end
_G._htop_toggle = function()
    htop:toggle()
end
