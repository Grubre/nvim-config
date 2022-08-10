local luasnip_loaded, luasnip = pcall(require,"luasnip")
if not luasnip_loaded then
    vim.notify("Luasnip failed to load!")
    return
end

local cmp_loaded, cmp  = pcall(require,"cmp")
if not cmp_loaded then
    vim.notify("Cmp failed to load!")
    return
end

require("luasnip/loaders/from_vscode").lazy_load()


-- OPTIONS
local max_menu_width = 80


local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Calc = "烈",
  Treesitter = "",
}


cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-c>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm(),
      ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
      end, {
        "i",
        "s",
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
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
          path = "[Path]",
          calc = "[Math]",
          treesitter = "[Treesitter]",
        })[entry.source.name]
        vim_item.abbr = string.sub(vim_item.abbr, 1, max_menu_width)
        return vim_item
      end,
    },
    sources = {
      { name = 'luasnip'},
      { name = 'nvim_lsp'},
      { name = 'buffer' , keyword_length = 4},
      { name = 'treesitter' , keyword_length = 4},
      { name = 'calc'},
      { name = 'path'},
    },
    experimental = {
        ghost_text = true,
    }
})



cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})


cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})
