return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
    enabled = not vim.g.vscode,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    enabled = not vim.g.vscode,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "pyright",
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "json",
        "yaml",
        "toml",
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local defaults = require "nvchad.configs.cmp"
      local custom = require "configs.cmp"
      return vim.tbl_deep_extend("force", defaults, custom)
    end,
    enabled = not vim.g.vscode,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function (_, opts)
      return vim.tbl_deep_extend("force", opts, {
        pickers = {
          git_files = {
            git_command = {'git', 'ls-files', '--exclude-standard', '--cached', '--others',},
          },
          find_files = {
            hidden = true,
          },
        },
      })
    end,
    keys = {
      { "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Telescope Find Git files" }}
    }
    --
    -- opts = {
    --   file_entry_encoding = "utf-8,sjis"
    -- },
    -- config = function(_, opts)
    --   print(vim.inspect(opts))
    --   require("telescope").setup(opts)
    --   print("hello?")
    -- end,
  }
}
