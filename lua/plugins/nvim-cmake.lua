local cmake_loaded, cmake = pcall(require, 'cmake')
if not cmake_loaded then
    vim.notify("nvim-cmake failed to load!")
    return
end
cmake.setup()
