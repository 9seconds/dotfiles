-- automatically close pairs
-- https://github.com/windwp/nvim-autopairs


return {
  "windwp/nvim-autopairs",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  event = "InsertEnter",

  opts = {
    enable_check_bracket_line = false,
    check_ts = true
  }
}
