local dressing_loaded, dressing  = pcall(require,"dressing")
if not dressing_loaded then
    vim.notify("Dressing failed to load!")
    return
end


dressing.setup({
  select = {
    get_config = function(opts)
      if opts.kind == 'codeaction' then
        return {
          backend = 'telescope',
          telescope = require("telescope.themes").get_cursor({layout_config={width=0.25}})
        }
      end
    end
  },
  input = {
  }
})

