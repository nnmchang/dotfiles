return{{
  "zbirenbaum/copilot-cmp",
  lazy = false,
  config = function ()
    require("copilot_cmp").setup()
  end,
  enabled = not vim.g.vscode,
}}
