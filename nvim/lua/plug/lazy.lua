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
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    lazy = true,
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    }
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },
  {
    -- Enables filtering See :h telescope-fzf-native.nvim-telescope-fzf-native-nvim
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { "nvim-telescope/telescope.nvim" }
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
      'kyazdani42/nvim-web-devicons'
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
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter'
    }
  },
  {
    'romgrk/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter'
    }
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = true,
    dependencies = {
      'nvim-treesitter'
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
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
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
    'ray-x/lsp_signature.nvim',
    lazy = true,
  },
  {
    'j-hui/fidget.nvim',
    config = function(plugin) require 'fidget'.setup {} end
  },
  {
    'onsails/lspkind.nvim',
    lazy = true,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    lazy = true,
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    cmd = 'TroubleToggle',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
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
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap"
    }
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap"
    }
  },
  {
    'leoluz/nvim-dap-go',
    lazy = true,
    ft = 'go',
    dependencies = {
      "mfussenegger/nvim-dap"
    }
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap"
    }
  },
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
    'folke/zen-mode.nvim',
    lazy = true,
    cmd = 'ZenMode',
    dependencies = {
      'folke/twilight.nvim'
    }
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
  },
  {
    'nathom/filetype.nvim',
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
      vim.o.timeoutlen = 500
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
    cmd = {'TodoTelescope', 'TodoTrouble'},
    config = function()
      require 'todo-comments'.setup {}
    end
  },
}
require("lazy").setup(plugins, {
  lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"
})
