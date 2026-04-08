-- a set of routines to use with vim.pack

local M = {}

local augroup = vim.api.nvim_create_augroup("9_VimPack", {})

function M.add(path, version, config, lazy)
  vim.pack.add(
    {
      {
        src = path,
        version = version,
      }
    },
    {
      load = function(data)
        local function loader()
          vim.cmd.packadd(data.spec.name)
          config()
        end

        if lazy == nil or lazy == false then
          return loader()
        end

        if lazy == true then
          return vim.schedule(loader)
        end

        vim.api.nvim_create_autocmd(
          lazy,
          {
            once = true,
            group = augroup,
            callback = loader,
          }
        )
      end
    }
  )
end

function M.on_update(name, action)
  vim.api.nvim_create_autocmd(
    "PackChanged",
    {
      group = augroup,
      callback = function(ev)
        if ev.data.spec.name == name and ev.data.kind ~= "delete" then
          if not ev.data.active then
            vim.cmd.packadd(name)
          end
          action()
        end
      end
    })
end

return M
