local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Sync packer after changes to 'plugins.lua' file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])



return require("packer").startup(function()
    use({
        "wbthomason/packer.nvim",                                      --Packer managing itself
        "nvim-lua/plenary.nvim",                                       --Dependency of some plugins
        "folke/lsp-colors.nvim",                                       --Add missing colors for colorschemes
        "tomasiser/vim-code-dark",                                     --Code Dark colorscheme
        { "catppuccin/nvim", as = "catppuccin" },                      --Catpuccin colorscheme
        "rebelot/kanagawa.nvim",                                       --Kanagawa colorscheme
        "bluz71/vim-moonfly-colors",                                   --Moonfly colorscheme
        "Shatur/neovim-ayu",                                           --Ayu colorscheme
        "eddyekofo94/gruvbox-flat.nvim",                               --Gruvbox flat colorscheme
        "folke/tokyonight.nvim",                                       --Tokyo Night colorscheme
        "kyazdani42/nvim-web-devicons",                                --Additional icons
        "hrsh7th/nvim-cmp",                                            --Auto-completion
        "rafamadriz/friendly-snippets",                                --Some snippets
        "L3MON4D3/LuaSnip",                                            --Snippets engine
        "ray-x/cmp-treesitter",                                        --Cmp integration with treesitter
        "hrsh7th/cmp-nvim-lsp",                                        --Cmp integration with lsp
        "hrsh7th/cmp-buffer",                                          --Cmp integration with buffer
        "hrsh7th/cmp-path",                                            --Cmp integration with path
        "hrsh7th/cmp-cmdline",                                         --Cmp integration with command line
        "hrsh7th/cmp-calc",                                            --Cmp integration with math
        "saadparwaiz1/cmp_luasnip",                                    --Cmp integration with snippets
        "neovim/nvim-lspconfig",                                       --LSP Configs
        "p00f/clangd_extensions.nvim",                                 --Clangd extensions
        "simrat39/rust-tools.nvim",                                    --Extra rust tools
        "williamboman/mason.nvim",                                     --LSP, DAP, Linters and formatters installer
        "williamboman/mason-lspconfig.nvim",                           --Mason integration with LSP
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",                --Diagonstics shown as lines
        "nvim-treesitter/nvim-treesitter",                             --Treesitter
        "nvim-treesitter/playground",                                  --Treesitter playground
        "sharkdp/fd",                                                  --Searches for entries in your filesystem (telescope dependency)
        "nvim-lualine/lualine.nvim",                                   --Statusline
        { "nvim-telescope/telescope.nvim", tag = "0.1.x" },            --Telescope
        "nvim-telescope/telescope-file-browser.nvim",                  --Telescope file browser extension
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },  --Telescope FZF extensions
        "BurntSushi/ripgrep",                                          --Grep (used for telescope)
        "ahmedkhalf/project.nvim",                                     --Project rooter
        "lewis6991/gitsigns.nvim",                                     --Git decorations
        "lukas-reineke/indent-blankline.nvim",                         --Indent Blankline
        "MunifTanjim/nui.nvim",                                        --GUI component lib
        "stevearc/dressing.nvim",                                      --Changes default neovim inputs and selects to UI
        { "akinsho/toggleterm.nvim",                  tag = "v2.*" },  --Terminal plugin
        "ray-x/lsp_signature.nvim",                                    --Shows function signature
        "windwp/nvim-autopairs",                                       --AutoPairs
        "numToStr/Comment.nvim",                                       --Allows commenting
        "mfussenegger/nvim-dap",                                       --Debugger
        "rcarriga/nvim-dap-ui",                                        --UI for dap
        "theHamsta/nvim-dap-virtual-text",                             --Inlay debugger text
        "https://gitlab.com/yorickpeterse/nvim-window",                --Magically switch windows
        "Shatur/neovim-cmake",                                         --CMake integration
        "zefei/vim-colortuner",                                        --Most important plugin
        "norcalli/nvim-colorizer.lua",                                 -- Displays RGB colors
        'folke/todo-comments.nvim',                                    --TO DO comments
        "lewis6991/impatient.nvim",                                    --Speeds up load times
        "grubre/templater.nvim",                                       --File templates
        {
            "iamcco/markdown-preview.nvim",
            run = "cd app && npm install",
            setup = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        },
        "https://github.com/ggandor/leap.nvim", -- S and s motions
        "kevinhwang91/nvim-hlslens",            --Search help
        "jalvesaq/Nvim-R",                      --R support
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    panel = {
                        enabled = true,
                        auto_refresh = true,
                    },
                    suggestion = {
                        enabled = true,
                        auto_trigger = true,
                        accept = false, -- disable built-in keymapping
                    },
                })

                local cmp_status_ok, cmp = pcall(require, "cmp")
                if cmp_status_ok then
                    cmp.event:on("menu_opened", function()
                        vim.b.copilot_suggestion_hidden = true
                    end)

                    cmp.event:on("menu_closed", function()
                        vim.b.copilot_suggestion_hidden = false
                    end)
                end
            end,
        }, -- copilot
        -- {
        --     "zbirenbaum/copilot-cmp",
        --     after = { "copilot.lua" },
        --     config = function()
        --         require("copilot_cmp").setup()
        --     end
        -- },
        "nvim-tree/nvim-tree.lua", -- File explorer
        "nvim-neotest/nvim-nio"
    })
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
