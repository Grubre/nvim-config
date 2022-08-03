local project_nvim_loaded, project_nvim = pcall(require,"project_nvim")
if not project_nvim_loaded then
    vim.notify("Project-nvim failed to load!")
    return
end
project_nvim.setup()

