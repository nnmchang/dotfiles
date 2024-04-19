local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
  },
}

require("conform").setup(options)
