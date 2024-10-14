return {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        whitespace = {
            remove_blankline_trail = true,
        },
        scope = { enabled = false },
    }
}
