-- show registers
-- https://github.com/tversteeg/registers.nvim


return {
  "tversteeg/registers.nvim",
	name = "registers",
	keys = {
		{ "\"",    mode = { "n", "v" } },
		{ "<C-R>", mode = "i" }
	},
	cmd = "Registers",

  opts = {},
}
