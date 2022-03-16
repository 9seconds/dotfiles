local utils = require("_utils")

-- ----------------------------------------------------------------------------
-- GLOBAL SETTINGS
-- ----------------------------------------------------------------------------

utils:set_indent(vim.o, 4)

vim.o.autoread = true                  -- suggest to reload if file was updated outside
vim.o.backup = false                   -- do not use backup after file is written
vim.o.breakindent = true               -- indent wrapped line
vim.o.breakindentopt = "shift:2"       -- how to display wrapped line
vim.o.clipboard = "unnamedplus"        -- clipboard integration
vim.o.cmdheight = 1                    -- number of lines for commandline
vim.o.colorcolumn = "80,120"           -- ruler lines on columns
vim.o.completeopt = "menu,menuone,preview" -- required for nvim-cmp
vim.o.cursorline = true                -- highlight a line where cursor is placed
vim.o.eol = true                       -- always set \n at the end of the file
vim.o.errorbells = false               -- do not issue error bell
vim.o.expandtab = true                 -- do not use tabs, only spaces
vim.o.hidden = true                    -- do not delete a buffer if file was deleted
vim.o.hlsearch = true                  -- highlight search
vim.o.inccommand = "nosplit"           -- incrementally update replaces
vim.o.joinspaces = false               -- do not insert 2 spaces after punctuation on each line join
vim.o.list = true                      -- show hidden characters
vim.o.listchars = "tab:▸ ,trail:⋅,extends:❯,precedes:❮"
vim.o.modeline = true                  -- respect file modelines
vim.o.mouse = "a"                      -- mouse support
vim.o.number = true                    -- show line numbers
vim.o.shell = "/bin/bash"              -- use bash as a default shell
vim.o.shiftround = true                -- round indent to shiftwidth
vim.o.shortmess = "Ic"                 -- do not show a welcome page
vim.o.showbreak = "↪"                  -- use this symbol to display a wrapped line
vim.o.showmatch = true                 -- show matching stuff
vim.o.showmode = false                 -- show current active mode
vim.o.signcolumn = "yes"               -- always reserve a space for a sign column
vim.o.smartcase = true                 -- smartcase search
vim.o.smartindent = true               -- enable smart indent
vim.o.smarttab = true                  -- understand when to insert and remove
vim.o.spelllang = "en_us"              -- a language to use for spellchecking
vim.o.splitbelow = true                -- horizontal split is always below
vim.o.splitright = true                -- vertical split is always on the right handsight
vim.o.swapfile = false                 -- do not use swapfile for buffer
vim.o.termguicolors = true             -- enable truecolors
vim.o.viminfo = ""                     -- do not use viminfo
vim.o.visualbell = false               -- do not issue visualbell
vim.o.writebackup = false              -- do not create backup during a file is written

if vim.fn.executable("rg") then
  vim.o.grepprg = "rg --vimgrep --fixed-strings --no-heading --smart-case"
end

if vim.fn.executable("prettypar") then
  vim.o.formatprg = "prettypar"
elseif vim.fn.executable("par") then
  vim.o.formatprg = "par"
end


-- ----------------------------------------------------------------------------
-- GLOBAL KEYMAPS
-- ----------------------------------------------------------------------------
-- space as a leader
utils:keynmap("", "<space>", "<nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- sudo write
utils:keynmap("c", "w!!", "w !sudo tee >/dev/null %")

-- more reasonable indents/unindents
utils:keynmap("v", "<", "<gv")
utils:keynmap("v", ">", ">gv")

-- wrapline-aware navigation
utils:keynmap("n", "j", "gj")
utils:keynmap("n", "k", "gk")
utils:keynmap("n", "$", "g$")
utils:keynmap("n", "0", "^")

-- center screen on search operations
utils:keynmap("n", "n", "nzz")
utils:keynmap("n", "N", "Nzz")
utils:keynmap("n", "*", "*zz``")
utils:keynmap("n", "#", "#zz")
utils:keynmap("n", "g*", "g*zz")
utils:keynmap("n", "g#", "g#zz")
utils:keynmap("n", "<c-d>", "<c-d>zz")
utils:keynmap("n", "<c-u>", "<c-u>zz")
utils:keynmap("n", "<c-f>", "<c-f>zz")
utils:keynmap("n", "<c-b>", "<c-b>zz")

-- split navigation
utils:keynmap("n", "<c-h>", "<c-w>h")
utils:keynmap("n", "<c-j>", "<c-w>j")
utils:keynmap("n", "<c-k>", "<c-w>k")
utils:keynmap("n", "<c-l>", "<c-w>l")

-- exit insert mode
utils:keynmap("i", "jk", "<esc>")
utils:keynmap("i", "jj", "<esc>")

-- sort
utils:keynmap("v", "<leader>s", ":sort i<cr>")

-- terminal mappings
utils:keynmap("t", "<c-j><c-j>", "<c-\\><c-n>")
utils:keynmap("t", "<c-j><c-k>", "<c-\\><c-n>")
utils:keynmap("t", "<a-h>", "<c-\\><c-n><c-w>h")
utils:keynmap("t", "<a-j>", "<c-\\><c-n><c-w>j")
utils:keynmap("t", "<a-k>", "<c-\\><c-n><c-w>k")
utils:keynmap("t", "<a-l>", "<c-\\><c-n><c-w>l")

-- fast access
utils:keynmap("n", "<leader>w", ":update<cr>")


-- ----------------------------------------------------------------------------
-- AUTO GROUPS
-- ----------------------------------------------------------------------------

-- resize panes on window resize
vim.cmd([[
augroup VimResizePanes
  autocmd!
  autocmd VimResized * exe "normal \<c-w>="
augroup END
]])

-- delete trailing whitespaces
vim.cmd([[
augroup StripTrailingWhitespaces
  autocmd!
  autocmd BufWritePre * let w:wv = winsaveview() | %s/\s\+$//e | call winrestview(w:wv)
augroup END
]])

-- hide cursorline when it makes sense
vim.cmd([[
augroup HideCursorline
  autocmd!
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
augroup END
]])

vim.cmd([[
augroup CorrectCTRLDForTerminal
  autocmd!
  autocmd TermClose * call feedkeys("\<esc>")
augroup END
]])


-- ----------------------------------------------------------------------------
-- PLUGINS
-- ----------------------------------------------------------------------------

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "ggandor/lightspeed.nvim"
  use "junegunn/vim-slash"
  use "machakann/vim-textobj-delimited"
  use "tpope/vim-repeat"
  use "tpope/vim-sensible"
  use "tpope/vim-surround"
  use "nathom/filetype.nvim"
  use "Vimjas/vim-python-pep8-indent"

  use {
    "hrsh7th/nvim-cmp",
    requires={
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
    },
    config=function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      local presets = {}
      for k, v in pairs(lspkind.presets.default) do
        presets[k] = v .. " " .. k
      end

      cmp.setup {
        sources={
          {name="nvim_lsp"},
          {name="path"},
          {name="buffer"},
        },

        formatting = {
          format=function(entry, vim_item)
            vim_item.kind = presets[vim_item.kind]
            return vim_item
          end
        },

        mapping={
          ["<tab>"]=cmp.mapping.select_next_item(),
          ["<s-tab>"]=cmp.mapping.select_prev_item(),
          ["<c-d>"]=cmp.mapping.scroll_docs(-4),
          ["<c-f>"]=cmp.mapping.scroll_docs(4),
          ["<c-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior=cmp.ConfirmBehavior.Replace,
            select=true,
          }
        }
      }
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    opt=false,
    requires={
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
    },
    config=function()
      require("nvim-treesitter.configs").setup {
        ensure_installed="maintained",

        rainbow={
          enable=true,
        },

        autopairs={
          enable=true
        },

        highlight={
          enable=true
        },

        indent={
          enable=true,
          disable={"python"},
        },

        textobjects={
          select={
            enable=true,
            lookahead=true,
            keymaps={
              ["af"]="@function.outer",
              ["if"]="@function.inner",
              ["ac"]="@class.outer",
              ["ic"]="@class.inner",
              ["ia"]="@parameter.inner",
              ["aa"]="@parameter.outer",
              ["ab"]="@block.outer",
              ["ib"]="@block.inner",
              ["ac"]="@call.outer",
              ["ic"]="@call.inner",
          },
          },
        },
      }
    end
  }

  use {
    "windwp/nvim-autopairs",
    opt=false,
    after={
      "nvim-treesitter",
      "nvim-cmp",
    },
    config=function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done {
          map_char={
            tex="",
          },
				}
      )

      require("nvim-autopairs").setup {
        check_ts=true,
      }
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    opt=false,
    after="nvim-treesitter",
    config=function()
      require("indent_blankline").setup {
        use_treesiter=true,
        char_list = {"│", "┆", "┊", "|", "¦"},
        show_first_indent_level=false,
        show_trailing_blankline_indent=false,
        show_end_of_line=false,
        buftype_exclude={"terminal"},
      }
    end
  }

  use {
    "EdenEast/nightfox.nvim",
    config=function()
      vim.cmd("colorscheme nordfox")
    end
  }

  use {
    "abecodes/tabout.nvim",
    opt=false,
    after="nvim-treesitter",
    config=function()
      local utils = require("_utils")

      require("tabout").setup {
        tabkey="",
        backwards_tabkey="",
        enable_backwards=false,
        act_as_tab=false,
        act_as_shift_tab=false,
      }
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    requires={
      "nvim-lua/plenary.nvim",
    },
    config=function()
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      gitsigns.setup({
        watch_gitdir={
          interval=1000,
          follow_lines=true,
        },
        update_debounce=1000,
        on_attach=function(bufnr)
          -- Navigation
          map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
          map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

          -- Actions
          map({'n', 'v'}, '<leader>hs', gitsigns.stage_hunk)
          map({'n', 'v'}, '<leader>hr', gitsigns.reset_hunk)
          map('n', '<leader>hS', gitsigns.stage_buffer)
          map('n', '<leader>hu', gitsigns.undo_stage_hunk)
          map('n', '<leader>hR', gitsigns.reset_buffer)
          map('n', '<leader>hp', gitsigns.preview_hunk)
          map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>hd', gitsigns.diffthis)
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
          map('n', '<leader>td', gitsigns.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end
  }

  use {
    "winston0410/range-highlight.nvim",
    requires={
      "winston0410/cmd-parser.nvim"
    },
    config=function()
      require("range-highlight").setup {}
    end
  }

  use {
    "hoob3rt/lualine.nvim",
    requires={
      "kyazdani42/nvim-web-devicons",
      {
        "SmiteshP/nvim-gps",
        requires={
          "nvim-treesitter/nvim-treesitter"
        }
      }
    },
    config=function()
      local gps = require("nvim-gps")

      gps.setup()

      require("lualine").setup {
        options={
          theme="nightfox",
          section_separators="",
          component_separators="",
        },
        extensions={
          'nvim-tree',
          'toggleterm',
          'quickfix',
        },
        sections={
          lualine_a={"mode"},
          lualine_b={{
            "b:gitsigns_head",
            icon = "",
            fmt=function(line)
              if vim.fn.winnr("$") > 1 then
                return ""
              end

              return line
            end,
          }},
          lualine_c={
            {
              "filename",
              path=2,
              shorting_target=30,
            }
          },
          lualine_x={
            {gps.get_location, cond=gps.is_available}
          },
          lualine_y={},
          lualine_z={"location"},
        }
      }
    end
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires={
      "kyazdani42/nvim-web-devicons"
    },
    config=function()
      local utils = require("_utils")

      vim.g.nvim_tree_show_icons = {
        git=1,
        folders=1,
        files=1,
        folder_arrows=1,
      }
      vim.g.nvim_tree_git_hl = 1

      require("nvim-tree").setup {
        auto_close=true,
        update_cwd=true,
        git={
          ignore=false
        },
        diagnostics={
          enable=false
        },
        view={
          width=50,
        },
        filters={
          dotfiles=false,
          custom={
            ".git",
            "*.pyc",
            "*.pyo",
            "__pycache__",
          },
        },
      }

      utils:keynmap("n", "<f2>", ":NvimTreeToggle<cr>")
      utils:keynmap("n", "<f3>", ":NvimTreeFindFile<cr>")
    end
  }

  use {
    "ahmedkhalf/project.nvim",
    config=function()
      require("project_nvim").setup {}

      vim.g.nvim_tree_respect_buf_cwd = 1
    end
  }


  use {
    "b3nj5m1n/kommentary",
    config=function()
      require("kommentary.config").configure_language("default", {
        prefer_single_line_comments=true,
        use_consistent_indentation=true,
        ignore_whitespace=false,
      })
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires={
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run="make"
      }
    },
    config=function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local utils = require("_utils")

      local find_command = {"find", ".", "-type", "f"}
      local vimgrep_arguments = nil

      if vim.fn.executable("rg") then
        find_command = {
          "rg",
          "--files",
          "--color", "never"
        }
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
        }
      elseif vim.fn.executable("fd") then
        find_command = {
            "fd",
          "--strip-cwd-prefix",
          "--color",
          "never",
          "--type",
          "file"
        }
      end

      telescope.setup({
        defaults={
          vimgrep_arguments=vimgrep_arguments,
          mappings={
            i={
              ["<esc>"]=actions.close,
            },
          },
        },
        pickers={
          find_files={
            find_command=find_command,
          },
        },
        extensions={
          fzf={
            fuzzy=true,
            override_generic_sorter=true,
            override_file_sorter=true,
            case_mode="smart_case",
          }
        }
      })
      telescope.load_extension("fzf")

      utils:keynmap(
        "n", "<leader>ff",
        "<cmd>lua require('telescope.builtin').find_files({previewer=false})<cr>"
      )
      utils:keynmap(
        "n", "<leader>fh",
        "<cmd>lua require('telescope.builtin').find_files({previewer=false, search_dirs={'~/.dotfiles'}})<cr>"
      )
      utils:keynmap(
        "n", "<leader>fb",
        "<cmd>lua require('telescope.builtin').buffers()<cr>"
      )
      utils:keynmap(
        "n", "<leader>fl",
        "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"
      )
      utils:keynmap(
        "n", "<leader>ft",
        "<cmd>lua require('telescope.builtin').tags()<cr>"
      )

      vim.cmd([[
        :command! -nargs=1 Grep :lua require('telescope.builtin').grep_string({search=vim.fn.expand('<args>')})
      ]])
      vim.api.nvim_set_keymap("n", "<leader>fg", ":Grep ", {})
    end
  }

  use {
    "williamboman/nvim-lsp-installer",
    requires={
      "neovim/nvim-lspconfig"
    }
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires={
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig"
    }
  }

  use {
    "max397574/better-escape.nvim",
    config=function()
      require("better_escape").setup()
    end
  }

  use {
    "folke/zen-mode.nvim",
    requires={
      "folke/twilight.nvim"
    },
    config=function()
      local utils= require("_utils")

      require("zen-mode").setup {
        window={
          width=200,
          options={
            number=false,
            signcolumn="no",
          }
        },
        on_open=function()
          vim.cmd("setlocal colorcolumn=")
        end,
        on_close=function()
          vim.o.colorcolumn = "80,120"
        end
      }

      utils:keynmap("n", "<leader>z", ":ZenMode<cr>")
    end
  }

  use {
    "hrsh7th/vim-vsnip",
    opt=false,
    after="tabout.nvim",
    config=function()
      local utils = require("_utils")

      vim.g.vsnip_snippet_dir = vim.fn.expand("~/.config/nvim/snippets")

      utils:keyemap(
        "i", "<c-j>",
        "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Plug>(TaboutMulti)'"
      )
      utils:keyemap(
        "s", "<c-j>",
        "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Plug>(TaboutMulti)'"
      )
      utils:keyemap(
        "i", "<c-k>",
        "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<c-k>'"
      )
      utils:keyemap(
        "s", "<c-k>",
        "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<c-k>'"
      )
    end
  }

  use {
    "folke/trouble.nvim",
    requires={
      "kyazdani42/nvim-web-devicons"
    },
    config=function()
      require("trouble").setup {
        mode="document_diagnostics",
      }

      local utils = require("_utils")

      utils:keynmap("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
      utils:keynmap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
      utils:keynmap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
      utils:keynmap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
      utils:keynmap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
    end
  }

  use {
    "akinsho/toggleterm.nvim",
    config=function()
      local Terminal = require("toggleterm.terminal").Terminal

      require("toggleterm").setup({
        hide_numbers=true,
        shade_terminals=false,
        shell=vim.env.SHELL or vim.o.shell,
        size=function(term)
          if term.direction == "horizontal" then
            return 23
          elseif term.direction == "vertical" then
            return vim.o.columns / 2
          end
        end
      })

      local lazygit = Terminal:new({
        cmd="lazygit",
        dir="git_dir",
        direction="float",
        float_opts={
          border="double",
        },
        hidden=true,
        count=3,
        on_open=function(term)
          local utils = require("_utils")
          local keymap = utils:get_buf_keymap(
            term.bufnr, {
              noremap=true,
              silent=true
            }
          )

          keymap("t", "<a-g>", "<cmd>close<cr>")
        end
      })
      vim.keymap.set("n", "<a-g>", function()
        lazygit:toggle()
      end)
    end
  }

  use {
    "mizlan/iswap.nvim",
    opt=false,
    after={
      "nvim-treesitter",
      "vim-repeat"
    },
    config=function()
      local utils = require("_utils")

      require("iswap").setup {
        keys="qwertyuiop",
        autoswap=true,
      }

      utils:keynmap("n", "<leader>s", "<cmd>ISwap<cr>")
    end
  }

  use {
    "jbyuki/venn.nvim",
    config=function()
      vim.keymap.set("n", "<leader>v", function()
        if vim.b.venn_enabled then
          vim.cmd("setlocal ve=")
          vim.cmd("mapclear <buffer>")
          vim.b.venn_enabled = nil

          return
        end

        vim.b.venn_enabled = true
        vim.cmd("setlocal ve=all")

        local keymap = require("_utils"):get_buf_keymap(0, {noremap=true})

        keymap("n", "J", "<C-v>j:VBox<cr>")
        keymap("n", "K", "<C-v>k:VBox<cr>")
        keymap("n", "L", "<C-v>l:VBox<cr>")
        keymap("n", "H", "<C-v>h:VBox<cr>")
        keymap("v", "f", ":VBox<cr>")
      end)
    end
  }

  use {
    "ludovicchabant/vim-gutentags",
    config=function()
      vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/gutentags")

      if vim.fn.executable("fd") then
        vim.g.gutentags_file_list_command = "fd --type f --full-path --color never ."
      end
    end
  }

end)


if vim.fn.filereadable(vim.fn.expand("$HOME/.local-vimrc.lua")) then
  vim.api.nvim_command("source $HOME/.local-vimrc.lua")
end


require("_lsp"):setup()
