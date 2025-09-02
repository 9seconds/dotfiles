-- fuzzy finder. faster than telescope on leblon, so be it
-- https://github.com/ibhagwan/fzf-lua

local function rg_glob(query)
  local chunks = vim.split(query, "--", {
    plain = true,
    trimempty = true,
  })

  if #chunks == 1 then
    return query
  end

  local new_query = ""
  for i = 2, #chunks do
    new_query = new_query .. " " .. chunks[i]
  end

  local flags = ""

  for _, word in ipairs(vim.split(chunks[1], " ", { trimempty = true })) do
    -- "+ -- something" -> rg --word-regexp something
    if word == "+" then
      flags = flags .. " --word-regexp"

    -- "! -- something" > rg -F something
    elseif word == "!" then
      flags = flags .. " --fixed-strings"

    -- ^python -> rg -t python
    elseif vim.startswith(word, "^") then
      flags = flags .. " -t " .. vim.fn.shellescape(word:sub(2))

    -- "-I -X ww" -> rg -I -X ww
    elseif vim.startswith(word, "-") then
      flags = flags .. " " .. word

    -- iglob clause
    else
      -- dots -> dots/**
      if not word:find("*") then
        if not vim.endswith(word, "/") then
          word = word .. "/"
        end
        word = word .. "**"
      end

      flags = ("%s --iglob %s"):format(flags, vim.fn.shellescape(word))
    end
  end

  flags = vim.trim(flags)
  new_query = vim.trim(new_query)

  -- io.write(("flags=%s | query=%s\n"):format(flags, query))

  return new_query, flags
end

return {
  "ibhagwan/fzf-lua",
  cond = vim.fn.executable("fzf"),
  dependencies = {
    "nvim-mini/mini.icons",
  },
  keys = {
    {
      "<leader>tt",
      function()
        return require("fzf-lua").files({})
      end,
      desc = "FZF: Files",
    },
    {
      "<leader>tb",
      function()
        return require("fzf-lua").buffers({})
      end,
      desc = "FZF: Buffers",
    },
    {
      "<leader>td",
      function()
        local fzf = require("fzf-lua")

        local success, symbols = pcall(vim.lsp.buf.document_symbol, {})
        if success and symbols then
          return fzf.lsp_document_symbols({})
        end
        return fzf.treesitter({})
      end,
      desc = "FZF: Symbols",
    },
    {
      "<leader>tD",
      function()
        return require("fzf-lua").lsp_workspace_symbols({})
      end,
      desc = "FZF: Buffers",
    },
    {
      "<leader>tG",
      function()
        return require("fzf-lua").grep_curbuf({})
      end,
      desc = "FZF: Grep current buffer",
    },
    {
      "<leader>tg",
      function()
        return require("fzf-lua").live_grep({})
      end,
      desc = "FZF: Grep",
    },
    {
      "<leader>ts",
      function()
        return require("fzf-lua").git_status({})
      end,
      desc = "FZF: Git status",
    },
    {
      "<leader>tr",
      function()
        return require("fzf-lua").lsp_references({})
      end,
      desc = "FZF: LSP references",
    },
    {
      "<leader>tc",
      function()
        return require("fzf-lua").lsp_incoming_calls({})
      end,
      desc = "FZF: LSP incoming calls",
    },
    {
      "<leader>tC",
      function()
        return require("fzf-lua").lsp_outgoing_calls({})
      end,
      desc = "FZF: LSP outgoing calls",
    },
  },
  cmd = {
    "FzfLua",
  },

  opts = {
    "fzf-native",
    fzf_colors = true,
    grep = {
      rg_glob = true,
      rg_glob_fn = rg_glob,
    },
  },
}
