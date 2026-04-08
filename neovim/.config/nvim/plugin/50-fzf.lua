-- fuzzy finder. faster than telescope on leblon, so be it
-- https://github.com/ibhagwan/fzf-lua

local function keymap(name, key, func)
  vim.keymap.set(
    "n",
    "<leader>t" .. key,
    func,
    {
      desc = "FZF: " .. name
    }
  )
end

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

  return new_query, flags
end

require("_.pack").add(
  "https://github.com/ibhagwan/fzf-lua",
  nil,
  function()
    local opts = {
      { "fzf-native", "borderless-full" },
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
      opts["fzf_bin"] = "sk"
      opts["fzf_opts"] = { ["--algo"] = "frizbee" }
      opts["fzf_colors"] = false
      opts[1][1] = "skim"
    end

    require("fzf-lua").setup(opts)

    keymap("Files", "t", function()
      return require("fzf-lua").files({})
    end)

    keymap("Dotfiles", "T", function()
      return require("fzf-lua").files({
        cwd = vim.env["9SECONDS_DIR_DOTFILES"] or "~/.dotfiles",
      })
    end)

    keymap("Buffers", "b", function()
        return require("fzf-lua").buffers({})
    end)

    keymap("Symbols", "s", function()
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
    end)

    keymap("All symbols", "S", function()
      return require("fzf-lua").lsp_workspace_symbols({})
    end)

    keymap("Grep", "f", function()
        return require("fzf-lua").live_grep({})
    end)

    keymap("Grep current buffer", "F", function()
        return require("fzf-lua").grep_curbuf({})
    end)

    keymap("Git status", "l", function()
        return require("fzf-lua").git_status({})
    end)

    keymap("References", "r", function()
        return require("fzf-lua").lsp_references({})
    end)

    keymap("Incoming calls", "c", function()
        return require("fzf-lua").lsp_incoming_calls({})
    end)

    keymap("Outgoing calls", "C", function()
        return require("fzf-lua").lsp_outgoing_calls({})
    end)

    keymap("Resume", "y", function()
        return require("fzf-lua").resume({})
    end)

    keymap("Diagnostics for current buffer", "d", function()
        return require("fzf-lua").diagnostics_document({})
    end)

    keymap("Diagnostics for workspace", "D", function()
        return require("fzf-lua").diagnostics_workspace({})
    end)
  end,
  true
)
