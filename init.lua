local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
require("core.options")
require("core.keymaps")

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("AndrewRadev/splitjoin.vim")
  use("tpope/vim-fugitive")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.snippets")
    end,
  })

  use({
    "mbbill/undotree",
    config = function()
      require("plugins.undotree")
    end,
  })

  use({
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      require("plugins.colors")
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.telescope")
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("plugins.terminal")
    end,
  })

  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("nvim-treesitter/nvim-treesitter-context")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("plugins.tree-sitter")
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    requires = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("plugins.lsp").setup()
    end,
  })

  use({
    "nvimtools/none-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.formatting")
    end,
  })

  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs").setup()
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })

  use({
    "chentoast/marks.nvim",
    -- config = function()
    --   require("plugins.marks").setup()
    -- end,
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "saadparwaiz1/cmp_luasnip" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      require("plugins.completion").setup()
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
