-- vim: ts=2:sw=2:sts=2
--[[

                       9seconds' init.lua

--]]

local keymap = require("helpers").keymap

-- ----------------------------------------------------------------------------
-- GLOBAL SETTINGS
-- ----------------------------------------------------------------------------

vim.o.autoread = true                  -- suggest to reload if file was updated outside
vim.o.backup = false                   -- do not use backup after file is written
vim.o.breakindent = true               -- indent wrapped line
vim.o.breakindentopt = "shift:2"       -- 2 spaced on wrapped line indent
vim.o.clipboard = "unnamedplus"        -- clipboard integration
vim.o.cmdheight = 1                    -- number of lines for commandline
vim.o.colorcolumn = "80,120"           -- ruler lines on columns
vim.o.cursorline = true                -- highlight a line where cursor is placed
vim.o.eol = true                       -- always set \n at the end of the file
vim.o.errorbells = false               -- do not issue error bell
vim.o.expandtab = true                 -- do not use tabs, only spaces
vim.o.hidden = true                    -- do not delete a buffer if file was deleted
vim.o.hlsearch = true                  -- highlight search
vim.o.joinspaces = false               -- do not insert 2 spaces after punctuation on each line join
vim.o.list = true                      -- show hidden characters
vim.o.listchars = "tab:▸ ,trail:⋅,extends:❯,precedes:❮"
vim.o.modeline = true                  -- respect file modelines
vim.o.mouse = "a"                      -- mouse support
vim.o.number = true                    -- show line numbers
vim.o.shiftround = true                -- round indent to shiftwidth
vim.o.shiftwidth = 4                   -- a number of spaces for autoindent
vim.o.shortmess = "Ic"                 -- do not show a welcome page
vim.o.showbreak = "↪"                  -- use this symbol to display a wrapped line
vim.o.showmatch = true                 -- show matching stuff
vim.o.showmode = false                  -- show current active mode
vim.o.signcolumn = "yes"               -- always reserve a space for a sign column
vim.o.smartcase = true                 -- smartcase search
vim.o.smartindent = true               -- enable smart indent
vim.o.smarttab = true                  -- understand when to insert and remove
vim.o.softtabstop = 4                  -- backspace unindent
vim.o.splitbelow = true                -- horizontal split is always below
vim.o.splitright = true                -- vertical split is always on the right handsight
vim.o.swapfile = false                 -- do not use swapfile for buffer
vim.o.tabstop = 4                      -- tab is 4 spaces
vim.o.termguicolors = true             -- enable truecolors
vim.o.visualbell = false               -- do not issue visualbell
vim.o.writebackup = false              -- do not create backup during a file is written
vim.o.viminfo = ""                     -- do not use viminfo
vim.o.inccommand = "nosplit"           -- incrementally update replaces
vim.o.completeopt = "menuone,noselect" -- asked by nvim-compe


-- ----------------------------------------------------------------------------
-- GLOBAL KEYMAPS
-- ----------------------------------------------------------------------------

-- space as a leader
keymap("", "<space>", "<nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- sudo write
keymap("c", "w!!", "w !sudo tee >/dev/null %")

-- more reasonable indents/unindents
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- wrapline-aware navigation
keymap("n", "j", "gj")
keymap("n", "k", "gk")
keymap("n", "$", "g$")
keymap("n", "0", "^")

-- center screen on search operations
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "*", "*zz``")
keymap("n", "#", "#zz")
keymap("n", "g*", "g*zz")
keymap("n", "g#", "g#zz")
keymap("n", "<c-d>", "<c-d>zz")
keymap("n", "<c-u>", "<c-u>zz")
keymap("n", "<c-f>", "<c-f>zz")
keymap("n", "<c-b>", "<c-b>zz")
keymap("n", "<leader>h", ":noh<cr>")

-- split navigation
keymap("n", "<c-h>", "<c-w>h")
keymap("n", "<c-j>", "<c-w>j")
keymap("n", "<c-k>", "<c-w>k")
keymap("n", "<c-l>", "<c-w>l")

-- exit insert mode
keymap("i", "jk", "<esc>")
keymap("i", "jj", "<esc>")

-- tab management
keymap("n", "<leader>t1", "1gt")
keymap("n", "<leader>t2", "2gt")
keymap("n", "<leader>t3", "3gt")
keymap("n", "<leader>t4", "4gt")
keymap("n", "<leader>t5", "5gt")
keymap("n", "<leader>t6", "6gt")
keymap("n", "<leader>t7", "7gt")
keymap("n", "<leader>t8", "8gt")
keymap("n", "<leader>t9", "9gt")
keymap("n", "<leader>tc", ":tabclose<cr>")

-- sort
keymap("v", "<leader>s", ":sort<cr>")

-- terminal mappings
keymap("n", "<leader>]", ":vsplit term://$SHELL<cr>i")
keymap("n", "<leader>[", ":split term://$SHELL<cr>i")
keymap("t", "<c-j><c-j>", "<c-\\><c-n>")
keymap("t", "<c-j><c-k>", "<c-\\><c-n>")

-- fast access
keymap("n", "<leader>q", ":q<cr>")
keymap("n", "<leader>w", ":update<cr>")


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
  autocmd BufWritePre * :%s/\s\+$//e
augroup END
]])

-- delete rulers from quickfix window
vim.cmd([[
augroup NoQuickfixRulers
  autocmd!
  autocmd FileType qf setlocal colorcolumn=
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
  autocmd TermClose * call feedkeys("i")
augroup END
]])

-- settings for filetypes
vim.cmd([[
augroup FileTypeMake
  autocmd!
  autocmd FileType make setlocal noexpandtab
augroup END

augroup FileTypeYAML
  autocmd!
  autocmd FileType yaml setlocal ts=2 sw=2 sts=2 expandtab
augroup END

augroup FileTypeJSON
  autocmd!
  autocmd FileType json setlocal ts=2 sw=2 sts=2 expandtab
augroup END
]])


-- ----------------------------------------------------------------------------
-- PLUGINS
-- ----------------------------------------------------------------------------

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "tpope/vim-sensible"

  use {
    "nvim-treesitter/nvim-treesitter",
    requires={
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    run=":TSUpdate",
  }

  use {
    "airblade/vim-rooter",
    config=function()
      vim.g.rooter_patterns = {
        ".git",
        "go.mod",
        "package.json",
        "setup.py",
        "Makefile",
      }
      vim.g.rooter_change_directory_for_non_project_files = "current"
      vim.g.rooter_silent_chdir = 1
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    requires={
      "nvim-lua/plenary.nvim",
    },
    config=function()
      require('gitsigns').setup()
    end
  }

  use "tpope/vim-repeat"
  use "ggandor/lightspeed.nvim"
  use "tpope/vim-surround"
  use "junegunn/vim-slash"
  use "machakann/vim-textobj-delimited"

  use {
    "Valloric/ListToggle",
    config=function()
      vim.g.lt_location_list_toggle_map = '<leader>ql'
      vim.g.lt_quickfix_list_toggle_map = '<leader>qq'
    end
  }

  use {
    "sainnhe/gruvbox-material",
    as="gruvbox-material",
    config=function()
      vim.g.background = "dark"
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_better_performance = 1
      vim.api.nvim_command("colorscheme gruvbox-material")
    end
  }

  use {
    "hoob3rt/lualine.nvim",
    requires={
      "kyazdani42/nvim-web-devicons"
    },
    config=function()
      require('lualine').setup {
        options={
          theme="auto",
          section_separators="",
          component_separators="",
        },
        sections={
          lualine_a={"mode"},
          lualine_b={"branch"},
          lualine_c={
            {
              "filename",
              path=2,
            }
          },
          lualine_x={},
          lualine_y={"filetype"},
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
      local keymap = require("helpers").keymap

      keymap("n", "<f2>", ":NvimTreeToggle<cr>")
      keymap("n", "<f3>", ":NvimTreeFindFile<cr>")

      vim.g.nvim_tree_width = 30
      vim.g.nvim_tree_gitignore = 1
      vim.g.nvim_tree_auto_close = true
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
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run="make"
      }
    },
    config=function()
      local keymap = require("helpers").keymap
      local telescope = require("telescope")

      keymap(
        "n", "<leader>ff",
        "<cmd>lua require('telescope.builtin').find_files()<cr>"
      )
      keymap(
        "n", "<leader>fr",
        "<cmd>lua require('telescope.builtin').live_grep()<cr>"
      )
      keymap(
        "n", "<leader>fb",
        "<cmd>lua require('telescope.builtin').buffers()<cr>"
      )
      keymap(
        "n", "<leader>fg",
        "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>"
      )

      telescope.setup {
        extensions = {
          fzf={
            fuzzy=true,
            override_generic_sorter=true,
            override_file_sorter=true,
            smart_case=true,
          }
        }
      }
      telescope.load_extension("fzf")
    end
  }

  use {
    "windwp/nvim-autopairs",
    config=function()
      require("nvim-autopairs").setup {}
    end
  }

  use {
    "kabouzeid/nvim-lspinstall",
    requires={
      "neovim/nvim-lspconfig"
    }
  }

  use {
    "hrsh7th/nvim-compe",
    config=function()
      require("compe").setup {
        enabled=true,
        source={
          path=true,
          nvim_lsp=true,
          vsnip=true,
          treesitter=false,
        },
      }
    end
  }

  use {
    "hrsh7th/vim-vsnip",
    requires={
      "hrsh7th/vim-vsnip-integ",
    },
    config=function()
      local keymap = require("helpers").keymap

      vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"

      keymap("n", "c", "<Plug>(vsnip-cut-text)", {noremap=false})
      keymap("x", "c", "<Plug>(vsnip-cut-text)", {noremap=false})
    end
  }

  use {
    "folke/zen-mode.nvim",
    requires={
      "folke/twilight.nvim"
    },
    config=function()
      local keymap = require("helpers").keymap

      require("zen-mode").setup {
        window={
          options={
            signcolumn="no"
          }
        },
        on_open=function()
          vim.cmd("setlocal colorcolumn=")
        end,
        on_close=function()
          vim.o.colorcolumn = "80,120"
        end
      }

      keymap("n", "<leader>z", ":ZenMode<cr>")
    end
  }
end)

require("nvim-treesitter.configs").setup {
  ensure_installed="maintained",

  highlight={
    enable=true
  },

  indent={
    enable=true
  },

  incremental_selection={
    enable=true,
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
      },
    },
  },
}


pcall(function()
  vim.api.nvim_command("source $HOME/.local-vimrc.lua")
end)


require("compe_helpers"):setup()
require("lsp_helpers"):setup()
