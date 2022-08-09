-- TO DO

local M = {}

M.cmake_build_func = function()
    progress = require("plugins.nvim-cmake").progress


    if progress == "[100%]" then
        return ""
    else
        return progress
    end
end


return M
