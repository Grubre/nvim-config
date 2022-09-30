require("templater").setup({
	variables = {
		["TEST2"] = require("templater.templates").string("abc"),
	},
})
