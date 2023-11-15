local autopairs_loaded, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_loaded then
    vim.notify("Autopairs failed to load!")
    return
end

autopairs.setup({
    enable_check_bracket_line = true,
    fast_wrap = {
        map = "<a-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
    },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local _ = require("nvim-autopairs.rule")
