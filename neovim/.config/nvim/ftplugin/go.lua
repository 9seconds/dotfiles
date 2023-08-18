local utils = require("_.utils")

utils.set_indent(4, vim.bo)
vim.bo.expandtab = true

-- autosave and autoimports
-- vim.g._go_auto_organize_imports = true for automatic imports organize
-- vim.g._go_auto_format = true for automatic formatting
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  group = vim.api.nvim_create_augroup("Golang", {}),
  callback = function()
    if vim.g._go_auto_organize_imports then
      vim.lsp.buf.code_action({
        context = {
          only = {
            "source.organizeImports",
          },
        },
        apply = true,
      })
    end

    if vim.g._go_auto_format then
      vim.lsp.buf.format()
      -- this is required to avoid a message that formatting is done
      vim.fn.feedkeys("<cr>")
    end
  end,
})
