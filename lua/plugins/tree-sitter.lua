-------------------------
-- TREE-SITTER        --
-- (Syntax Highlight) --
-------------------------

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (parsers used for these languages)
  ensure_installed = {
    "lua", "vim", "vimdoc", "query", -- Neovim-related
    "javascript", "typescript", "tsx", -- Web development
    "python", "rust", "c", "cpp", -- Common programming languages
    "markdown", "markdown_inline", -- Documentation
    "bash", "fish", -- Shell scripting
    "json", "yaml", "toml", -- Data formats
    "html", "css", -- Web markup
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    -- Enable highlighting
    enable = true,

    -- Set to true to disable highlight for specific languages
    disable = {},

    -- Instead of true/false, set to "all" to use this setting for all parsers
    -- Or set to a list of languages to disable highlighting for
    additional_vim_regex_highlighting = false,
  },

  indent = {
    -- Enable indentation based on Tree-sitter
    enable = true,
  },

  -- Incremental selection based on syntax tree
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>ss", -- <Space>ss to start selection
      node_incremental = "<leader>si", -- <Space>si to expand selection
      scope_incremental = "<leader>sc", -- <Space>sc to expand to scope
      node_decremental = "<leader>sd", -- <Space>sd to shrink selection
    },
  },

  -- Enable Tree-sitter integration with textobjects
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["a/"] = "@comment.outer",
        ["i/"] = "@comment.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- Whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]p"] = "@parameter.outer",
        ["]b"] = "@block.outer",
        ["]l"] = "@loop.outer",
        ["]i"] = "@conditional.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]P"] = "@parameter.outer",
        ["]B"] = "@block.outer",
        ["]L"] = "@loop.outer",
        ["]I"] = "@conditional.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[p"] = "@parameter.outer",
        ["[b"] = "@block.outer",
        ["[l"] = "@loop.outer",
        ["[i"] = "@conditional.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[P"] = "@parameter.outer",
        ["[B"] = "@block.outer",
        ["[L"] = "@loop.outer",
        ["[I"] = "@conditional.outer",
      },
    },
  },
})

-- Enable folding based on Tree-sitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim-treesitter#foldexpr()"
vim.opt.foldenable = false -- Don't fold by default when opening files
