-- This module contains different autocommands and autogroups

local exrc_files = {
  ".nvim.lua",
  ".nvimrc",
  ".exrc",
}

return {
  setup = function()
    -- resize panes on window resize
    local augroup_resize_panes =
      vim.api.nvim_create_augroup("9_ResizePanes", {})
    vim.api.nvim_create_autocmd("VimResized", {
      group = augroup_resize_panes,
      command = "normal <c-w>=",
    })

    -- delete trailing whitespaces
    local augroup_strip_traling_whitespaces =
      vim.api.nvim_create_augroup("9_StripTrailingWhitespaces", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_strip_traling_whitespaces,
      callback = function()
        local save = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(save)
      end,
    })

    local augroup_resource_exrc =
      vim.api.nvim_create_augroup("9_ResourceExrc", {})
    vim.api.nvim_create_autocmd("DirChanged", {
      group = augroup_resource_exrc,
      callback = function()
        local uv = vim.uv or vim.loop
        local p_path = require("plenary.path")

        local root = p_path:new(uv.cwd())
        for i, v in ipairs(exrc_files) do
          local filepath = tostring(root:joinpath(v))
          local content = vim.secure.read(filepath)

          if content ~= nil then
            vim.cmd("source " .. filepath)

            if package.loaded.lspconfig ~= nil then
              vim.api.nvim_exec2("LspStop", {})
              vim.api.nvim_exec2("LspStart", {})
            end

            return
          end
        end
      end,
    })
  end,
}
