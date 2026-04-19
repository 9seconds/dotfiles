-- This module contains different autocommands and autogroups

local function setup()
  -- resize panes on window resize
  vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("9_ResizePanes", {}),
    command = "normal <c-w>=",
  })

  -- delete trailing whitespaces
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("9_StripTrailingWhitespaces", {}),
    callback = function()
      local save = vim.fn.winsaveview()
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.winrestview(save)
    end,
  })

  -- clear search highlight on cursor move
  vim.on_key(function(char)
    if vim.fn.mode() == "n" then
      local key = vim.fn.keytrans(char)
      local dominated_by_search =
        vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, key)
      if vim.opt.hlsearch:get() ~= dominated_by_search then
        vim.opt.hlsearch = dominated_by_search
      end
    end
  end, vim.api.nvim_create_namespace("9_AutoNoHlsearch"))

  -- disable mini.pairs for prompts
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("9_MiniPairs", {}),
    callback = function()
      if vim.bo.buftype == "prompt" then
        vim.b.minipairs_disable = true
      end
    end,
  })

  -- set diagnostic on change
  vim.api.nvim_create_autocmd({ "BufEnter", "DiagnosticChanged" }, {
    group = vim.api.nvim_create_augroup("9_Diagnostics", {}),
    callback = vim.schedule_wrap(function()
      if vim.bo.buftype == "" then
        vim.diagnostic.setloclist({
          open = false,
        })
      end
    end),
  })
end

-- cleanup unused plugins
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    local disabled_plugins = vim
      .iter(vim.pack.get())
      :filter(function(x)
        return not x.active
      end)
      :map(function(x)
        return x.spec.name
      end)
      :totable()

    if #disabled_plugins > 0 then
      vim.pack.del(disabled_plugins)
    end
  end),
})

setup()
