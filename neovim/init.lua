-- ----------------------------------------------------------------------------
-- GLOBAL SETTINGS
-- ----------------------------------------------------------------------------

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
vim.o.laststatus = 3                   -- do always set a global status line
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
vim.o.tabstop = 4                      -- number of spaces a <tab> in the file counts for
vim.o.softtabstop = 4                  -- number of spaces a <tab> counts for on editing (<BS> eg.)
vim.o.shiftwidth = 4                   -- number of spaces for each step of autoindent

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
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- space as a leader
vim.keymap.set({"n", "v"}, "<space>", "<nop>")

-- sudo write
vim.keymap.set("c", "w!!", "w !sudo tee >/dev/null %")

-- more reasonable indents/unindents
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- wrapline-aware navigation
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "$", "g$")
vim.keymap.set("n", "0", "^")
-- center screen on search operations
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz``")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-f>", "<c-f>zz")
vim.keymap.set("n", "<c-b>", "<c-b>zz")

-- split navigation
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- exit insert mode
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "jj", "<esc>")

-- sort
vim.keymap.set("v", "<leader>s", ":sort i<cr>")

-- terminal mappings
vim.keymap.set("t", "<c-j><c-j>", "<c-\\><c-n>")
vim.keymap.set("t", "<c-j><c-k>", "<c-\\><c-n>")
vim.keymap.set("t", "<a-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<a-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<a-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<a-l>", "<c-\\><c-n><c-w>l")

-- fast access
vim.keymap.set("n", "<leader>w", ":update<cr>")


-- ----------------------------------------------------------------------------
-- AUTO GROUPS
-- ----------------------------------------------------------------------------

-- resize panes on window resize
local augroup_resize_panes = vim.api.nvim_create_augroup("ResizePanes", {})
vim.api.nvim_create_autocmd("VimResized", {
  group=augroup_resize_panes,
  command="normal <c-w>="
})

-- delete trailing whitespaces
local augroup_strip_traling_whitespaces = vim.api.nvim_create_augroup(
  "StripTrailingWhitespaces", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group=augroup_strip_traling_whitespaces,
  callback=function()
    local save = vim.fn.winsaveview()
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.winrestview(save)
  end
})

-- hide cursorline when it makes sense
local augroup_hide_cursor_line = vim.api.nvim_create_augroup(
  "HideCursorline", {})
vim.api.nvim_create_autocmd({"InsertLeave", "WinEnter"}, {
  group=augroup_hide_cursor_line,
  callback=function()
    vim.wo.cursorline = true
  end
})
vim.api.nvim_create_autocmd({"InsertEnter", "WinLeave"}, {
  group=augroup_hide_cursor_line,
  callback=function()
    vim.wo.cursorline = false
  end
})

local augroup_correct_ctrld_for_terminal = vim.api.nvim_create_augroup(
  "CorrectCTRLDForTerminal", {})
vim.api.nvim_create_autocmd("TermClose", {
  group=augroup_correct_ctrld_for_terminal,
  callback=function()
    vim.fn.feedkeys("<esc>")
  end
})


-- ----------------------------------------------------------------------------
-- PLUGINS
-- ----------------------------------------------------------------------------

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "ggandor/lightspeed.nvim"
  use "junegunn/vim-slash"
  use "machakann/vim-textobj-delimited"
  use "tpope/vim-repeat"
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
      "saadparwaiz1/cmp_luasnip",
    },
    config=function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup {
        sources={
          {name="nvim_lsp"},
          {name="path"},
          {name="buffer"},
          {name="luasnip"},
        },

        formatting = {
          format = lspkind.cmp_format({
            mode="symbol",
            maxwidth=50,
          })
        },

        mapping={
          ["<tab>"]=cmp.mapping.select_next_item(),
          ["<c-n>"]=cmp.mapping.select_next_item(),
          ["<s-tab>"]=cmp.mapping.select_prev_item(),
          ["<c-p>"]=cmp.mapping.select_prev_item(),
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
        ensure_installed="all",

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
    "sainnhe/everforest",
    config=function()
      vim.g.everforest_background = "soft"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_better_performance = 1
      vim.cmd("colorscheme everforest")
    end
  }

  use {
    "abecodes/tabout.nvim",
    opt=false,
    after="nvim-treesitter",
    config=function()
      require("tabout").setup({
        act_as_tab=false
      })
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    requires={
      "nvim-lua/plenary.nvim",
    },
    config=function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        on_attach=function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, {expr=true})

          map("n", "[c", function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, {expr=true})

          -- Actions
          map({'n', 'v'}, '<leader>hs', gs.stage_hunk)
          map({'n', 'v'}, '<leader>hr', gs.reset_hunk)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line({full=true}) end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', gs.select_hunk)
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
    "nvim-lualine/lualine.nvim",
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
          theme="everforest",
          section_separators="",
          component_separators="",
          always_divide_middle=false,
          globalstatus=true,
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
      local nvim_tree = require("nvim-tree")

      vim.g.nvim_tree_show_icons = {
        git=1,
        folders=1,
        files=1,
        folder_arrows=1,
      }
      vim.g.nvim_tree_git_hl = 1

      nvim_tree.setup {
        update_cwd=true,
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

      vim.keymap.set("n", "<F2>", nvim_tree.toggle)
      vim.keymap.set("n", "<F3>", function()
        nvim_tree.find_file(true)
      end)
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
    "numToStr/Comment.nvim",
    config=function()
      require("Comment").setup()
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires={
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "natecraddock/telescope-zf-native.nvim",
    },
    config=function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

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
      })
      require("telescope").load_extension("zf-native")

      vim.keymap.set("n", "<leader>ff", function()
        require('telescope.builtin').find_files({previewer=false})
      end)

      vim.keymap.set("n", "<leader>fh", function()
        require('telescope.builtin').find_files(
          {previewer=false, search_dirs={"~/.dotfiles"}}
        )
      end)

      vim.keymap.set("n", "<leader>fb", function()
        require('telescope.builtin').buffers()
      end)

      vim.keymap.set("n", "<leader>fl", function()
        require('telescope.builtin').current_buffer_fuzzy_find()
      end)

      vim.keymap.set("n", "<leader>ft", function()
        require('telescope.builtin').tags()
      end)

      vim.keymap.set("n", "<leader>fg", function()
        require('telescope.builtin').live_grep()
      end)
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
    "L3MON4D3/LuaSnip",
    opt=false,
    config=function()
      local luasnip = require("luasnip")
      local loader = require("luasnip.loaders.from_lua")

      luasnip.config.set_config({
        history=false,
        update_events="TextChanged,TextChangedI",
      })

      loader.load({paths="~/.config/nvim/snippets"})

      vim.api.nvim_create_user_command("LuaSnipEdit", loader.edit_snippet_files, {})
      vim.keymap.set(
        {"i", "s"},
        "<c-j>",
        function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            vim.fn.feedkeys(
              vim.api.nvim_replace_termcodes("<Plug>(TaboutMulti)", true, true, true),
              "")
          end
        end,
        {silent=true})

      vim.keymap.set(
        {"i", "s"},
        "<c-k>",
        function()
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end,
        {silent=true})

      vim.keymap.set(
        "i",
        "<c-l>",
        function()
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end, {silent=true})
    end
  }

  use {
    "folke/trouble.nvim",
    requires={
      "kyazdani42/nvim-web-devicons"
    },
    config=function()
      local tr = require("trouble")

      tr.setup({
        mode="document_diagnostics",
      })

      vim.keymap.set("n", "<leader>xx", tr.toggle)
      vim.keymap.set("n", "<leader>xw", function()
        tr.toggle("workspace_diagnostics")
      end)
      vim.keymap.set("n", "<leader>xd", function()
        tr.toggle("document_diagnostics")
      end)
      vim.keymap.set("n", "<leader>xq", function()
        tr.toggle("quickfix")
      end)
      vim.keymap.set("n", "<leader>xl", function()
        tr.toggle("loclist")
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
      local iswap = require("iswap")

      require("iswap").setup {
        keys="qwertyuiop",
        autoswap=true,
      }

      vim.keymap.set("n", "<leader>s", iswap.iswap)
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

  use {
    "AckslD/nvim-trevJ.lua",
    config=function()
      local trevj = require("trevj")

      trevj.setup()

      vim.keymap.set("n", "K", trevj.format_at_cursor)
    end
  }
end)


if vim.fn.filereadable(vim.fn.expand("$HOME/.local-vimrc.lua")) then
  vim.api.nvim_command("source $HOME/.local-vimrc.lua")
end


require("_lsp"):setup()
