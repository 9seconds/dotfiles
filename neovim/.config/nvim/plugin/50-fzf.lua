-- fuzzy finder. faster than telescope on leblon, so be it
-- https://github.com/ibhagwan/fzf-lua

vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})

local mod = require("fzf-lua")
local map = require("_.utils").keymap("FZF", "<leader>t")

local function keymap(description, key, callback, opts)
  opts = opts or {}
  opts.winopts = { title = " " .. description .. " " }

  map(description, key, function ()
    callback(opts)
  end)
end

local opts = {
  { "fzf-native", "borderless-full" },
  fzf_colors = true,
  grep = {
    rg_glob = true,
  },
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
}

if vim.fn.executable("sk") then
  opts["fzf_bin"] = "sk"
  opts["fzf_opts"] = { ["--algo"] = "frizbee" }
  opts["fzf_colors"] = true
  opts[1][1] = "skim"
end

mod.setup(opts)

keymap("Files", "t", mod.files)
keymap("Dotfiles", "T", mod.files, {
  cwd = vim.uv.fs_realpath(vim.env["9SECONDS_DIR_DOTFILES"] or "~/.dotfiles"),
})

keymap("Marks", "m", mod.marks)
keymap("Global marks", "M", mod.marks, { marks = "^[A-Z]" })

keymap("Symbols", "s", function (opts)
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
  })

  for _, client in ipairs(clients) do
    if client.server_capabilities and client.server_capabilities.documentSymbolProvider then
      return mod.lsp_document_symbols(opts)
    end
  end

  return mod.treesitter(opts)
end)
keymap("All symbols", "S", mod.lsp_workspace_symbols)

keymap("Grep", "f", mod.live_grep)
keymap("Grep current buffer", "F", mod.grep_curbuf)

keymap("Git status", "l", mod.git_stash)
keymap("References", "r", mod.lsp_references)
keymap("Resume", "y", mod.resume)

keymap("Diagnostics for the current buffer", "d", mod.diagnostics_document)
keymap("Diagnostics for the workspace", "D", mod.diagnostics_workspace)
