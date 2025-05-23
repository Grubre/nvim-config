local max_menu_width = 80

local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
  Calc = "",
  Treesitter = "",
}

local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'FelipeLema/cmp-async-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-buffer'
    },
}

M.config = function()
    local cmp = require("cmp")
    local luasnip = require('luasnip')

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        sorting = {
            priority_weight = 1.0,
            comparators = {
                require("clangd_extensions.cmp_scores"),
                cmp.config.compare.score,
                cmp.config.compare.exact,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.order,
                cmp.config.compare.offset,
            },
        },
        mapping = {
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<Up>"] = cmp.mapping.select_prev_item(),
            ["<Down>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-c>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expandable() then
                    luasnip.expand()
                elseif require("copilot.suggestion").is_visible() then
                    require("copilot.suggestion").accept()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {
                    "i",
                    "s",
                }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                    "i",
                    "s",
                }),
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                --vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    async_path = "[Path]",
                    calc = "[Math]",
                    treesitter = "[Treesitter]",
                    -- copilot = "[Copilot]",
                })[entry.source.name]
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_menu_width)
                return vim_item
            end,
        },
        sources = {
            { name = "luasnip",    group_index = 1 },
            { name = "nvim_lsp",   group_index = 1 },
            -- { name = "copilot",    group_index = 1 },
            { name = "buffer",     group_index = 2, keyword_length = 4 },
            { name = "treesitter", group_index = 2, keyword_length = 4 },
            { name = "calc",       group_index = 2 },
            { name = "async_path", group_index = 2 },
        },
        experimental = {
            ghost_text = true,
        },
    })

    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "cmdline" },
        },
    })
end

return M
