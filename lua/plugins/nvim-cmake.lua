local cmake_loaded, cmake = pcall(require, "cmake")
if not cmake_loaded then
	vim.notify("nvim-cmake failed to load!")
	return
end

local M = {}
M.progress = ""

cmake.setup({
	dap_configuration = {
		type = "lldb",
		request = "launch",
		stopOnEntry = false,
		runInTerminal = false,
	},
	parameters_file = "nvim_cmake_config.json",
	quickfix = {
		pos = "vert",
		height = 100,
	},
	on_build_output = function(lines)
		-- Get only last line
		-- local match = string.match(lines[#lines], "(%[.*%])")
		local match = lines[#lines]
		if match then
			M.progress = string.gsub(match, "%%", "%%%%")
		end
		M.progress = match
	end,
})

M.cmake_build = function()
	local job = require("cmake").build()
	if job then
		job:after(vim.schedule_wrap(function(_, exit_code)
			if exit_code == 0 then
				vim.notify("Target was built successfully", vim.log.levels.INFO, { title = "CMake" })
			else
				vim.notify("Target build failed", vim.log.levels.ERROR, { title = "CMake" })
			end
		end))
	end
end

return M
