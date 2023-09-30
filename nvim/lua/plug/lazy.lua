local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Enables filtering See :h telescope-fzf-native.nvim-telescope-fzf-native-nvim
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },
  {
    'stevearc/dressing.nvim',
    lazy = true
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    keys = { 'gcc', 'gb' },
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'romgrk/nvim-treesitter-context',
      {
        'windwp/nvim-ts-autotag',
        lazy = true,
        ft = { 'html' },
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    }
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      {
        'ray-x/lsp_signature.nvim',
        lazy = true,
        config = function()
          require 'lsp_signature'.setup {
            zindex = 40,
          }
        end,
      },
      {
        'onsails/lspkind.nvim',
        lazy = true,
      },
    }
  },
  {
    -- Snippets
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    }
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function(_)
      require 'fidget'.setup {
        sources = {
          jdtls = {        -- Name of LSP client
            ignore = true, -- Ignore notifications from this source
          },
          lua_ls = {
            ignore = true, -- Ignore notifications from this source
          }
        },
      }
    end
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    cmd = 'TroubleToggle',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },
  {
    'scalameta/nvim-metals',
    lazy = true,
    ft = 'scala',
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      { "rcarriga/nvim-dap-ui",            lazy = true },
      { 'theHamsta/nvim-dap-virtual-text', lazy = true },
      { 'leoluz/nvim-dap-go',              ft = 'go',  lazy = true },
      {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = {
          'nvim-telescope/telescope.nvim' }
      },
    }
  },
  { 'mfussenegger/nvim-jdtls',  lazy = true, ft = 'java' },
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    cmd = 'ToggleTerm',
    version = '*'
  },
  {
    'windwp/nvim-autopairs'
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
  },
  {
    'mbbill/undotree',
    lazy = true,
    cmd = 'UndotreeToggle'
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        plugins = {
          presets = {
            operators = false,
            motions = false,
          },
        },
        key_labels = {
          ["<space>"] = "SPACE",
          ["<tab>"] = "TAB",
        },
        window = {
          position = "top",
        },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    cmd = { 'TodoTelescope', 'TodoTrouble' },
    config = function()
      require 'todo-comments'.setup {}
    end
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    config = function()
      require 'diffview'.setup {
        view = {
          merge_tool = {
            layout = "diff3_mixed",
          }
        }
      }
    end
  },
  {
    "udalov/kotlin-vim",
    ft = 'kotlin',
  },
  {
    "mfussenegger/nvim-lint",
    ft = { 'clojure', 'python', 'go', 'yaml' },
    config = function()
      require("lint").linters_by_ft = {
        clojure = { "clj-kondo" },
        python = { "flake8", "mypy" },
        go = { "golangcilint" },
        yaml = { "yamllint", "cfn_lint" },
      }
    end,
  },
  {
    "clojure-vim/vim-jack-in",
    dependencies = { "radenling/vim-dispatch-neovim", "tpope/vim-dispatch" },
    ft = 'clojure',
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    ft = 'clojure',
  },
  {
    "Olical/conjure",
    ft = { "clojure", "python" }, -- etc
    dependencies = { "PaterJason/cmp-conjure" },
    config = function()
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      -- Set configuration options here
      vim.g["conjure#debug"] = false
      -- vim.g["conjure#mapping#prefix"] = "<space>c"
      vim.g["conjure#mapping#doc_word"] = false           -- don't bind to K
      vim.g["conjure#mapping#enable_ft_mappings"] = false -- will config via which-key
      vim.g["conjure#log#hud#ignore_low_priority"] = true
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#log#hud#width"] = 1.0
    end,
  },
  {
    "mhartington/formatter.nvim", -- non-LSP formatting support
    ft = { 'python' },
    config = function()
      require('formatter').setup {
        filetype = {
          python = {
            require 'formatter.filetypes.python'.black,
          }
        }
      }
    end
  },
}
require("lazy").setup(plugins, {
  lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"
})
