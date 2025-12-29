-- autopairing
-- https://github.com/saghen/blink.pairs

return {
  "saghen/blink.pairs",
  version = "*",
  dependencies = {
    "saghen/blink.download",
  },
  event = {
    "BufRead",
    "BufNew",
  },

  opts = {},
}
