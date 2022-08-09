local telescope_loaded, telescope  = pcall(require,"telescope")
if not telescope_loaded then
    vim.notify("Telescope failed to load!")
    return
end

local actions_loaded, actions  = pcall(require,"telescope.actions")
if not actions_loaded then
    vim.notify("Actions failed to load!")
    return
end

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["esc"] = actions.close
            },
            n = {
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
        }
    },
}

-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("file_browser")
if not vim.fn.has("win32") then
    telescope.load_extension('fzf')
end
