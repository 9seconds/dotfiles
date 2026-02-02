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

      flags = string.format("%s --iglob %s", flags, vim.fn.shellescape(word))
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
      "<leader>tT",
      function()
        return require("fzf-lua").files({
          cwd = vim.env["9SECONDS_DIR_DOTFILES"] or "~/.dotfiles",
        })
      end,
      desc = "FZF: Dotfiles",
    },
    {
      "<leader>tb",
      function()
        return require("fzf-lua").buffers({})
      end,
      desc = "FZF: Buffers",
    },
    {
      "<leader>ts",
      function()
        local fzf = require("fzf-lua")
        local clients = vim.lsp.get_clients({
          bufnr = vim.api.nvim_get_current_buf(),
        })

        for _, client in ipairs(clients) do
          if
            client.server_capabilities
            and client.server_capabilities.documentSymbolProvider
          then
            return fzf.lsp_document_symbols({})
          end
        end

        return fzf.treesitter({})
      end,
      desc = "FZF: Symbols",
    },
    {
      "<leader>tS",
      function()
        return require("fzf-lua").lsp_workspace_symbols({})
      end,
      desc = "FZF: Buffers",
    },
    {
      "<leader>tF",
      function()
        return require("fzf-lua").grep_curbuf({})
      end,
      desc = "FZF: Grep current buffer",
    },
    {
      "<leader>tf",
      function()
        return require("fzf-lua").live_grep({})
      end,
      desc = "FZF: Grep",
    },
    {
      "<leader>tl",
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
    {
      "<leader>ty",
      function()
        return require("fzf-lua").resume({})
      end,
      desc = "FZF: Resume previous fzf session",
    },
    {
      "<leader>td",
      function()
        return require("fzf-lua").diagnostics_document({})
      end,
      desc = "FZF: List diagnistics for current buffer",
    },
    {
      "<leader>tD",
      function()
        return require("fzf-lua").diagnostics_workspace({})
      end,
      desc = "FZF: List diagnistics for workspace",
    },
  },
  cmd = {
    "FzfLua",
  },

  opts = function()
    local base = {
      "fzf-native",
      fzf_colors = true,
      grep = {
        rg_glob = true,
        rg_glob_fn = rg_glob,
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
    }

    if vim.fn.executable("sk") then
      base["fzf_bin"] = "sk"
      base["fzf_opts"] = { ["--algo"] = "frizbee" }
    end

    return base
  end,
}
