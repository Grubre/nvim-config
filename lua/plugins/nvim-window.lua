-- make it very lazy

return {
    "yorickpeterse/nvim-window",
    keys = {
        -- Nvim window
        {"<space>", function() require("nvim-window").pick() end, desc = "Pick a window"},
    },
    opts = {
        chars = {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "a",
            "b",
            "c",
            "d",
            "e",
            "f",
            "g",
            "h",
            "i",
            "j",
            "k",
            "l",
            "m",
            "n",
            "o",
            "p",
            "q",
            "r",
            "s",
            "t",
            "u",
            "v",
            "w",
            "x",
            "y",
            "z",
        },
    }
}
