vim.bo.expandtab = false


function _G.go_write_autocmd()
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}

  local result = vim.lsp.buf_request_sync(
    0,
    "textDocument/codeAction",
    params,
    3000
  )

  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end

  vim.lsp.buf.formatting()
end


vim.cmd([[
augroup Golang
  autocmd!
  autocmd BufWritePre *.go :silent! lua go_write_autocmd()
augroup END
]])
