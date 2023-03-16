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
    config = function()
      -- load the colorscheme here
      vim.g.tokyonight_style = "night"
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    lazy = true,
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
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
    'stevearc/dressing.nvim',
    lazy = true
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
  },
  {
    'nvim-lualine/lualine.nvim',
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
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-calc',
      { 'tzachar/cmp-tabnine', build = './install.sh' }
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
    'ray-x/lsp_signature.nvim'
  },
  {
    'j-hui/fidget.nvim',
    config = function(plugin) require 'fidget'.setup {} end
  },
  {
    'onsails/lspkind.nvim'
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    lazy = true,
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    }
  },
  {
    'scalameta/nvim-metals',
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
    version = '*'
  },
  {
    'windwp/nvim-autopairs'
  },
  {
    'folke/zen-mode.nvim',
    lazy = true,
    dependencies = {
      'folke/twilight.nvim'
    }
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
  },
  {
    'chentoast/marks.nvim'
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
}
require("lazy").setup(plugins, opts)
