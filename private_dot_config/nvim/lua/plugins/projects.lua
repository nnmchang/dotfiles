return {
  {
    "ahmedkhalf/project.nvim",
    event = { "VimEnter", "BufRead", "BufNewFile" },
    -- opts = {
    --   manual_mode = true,
    -- },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  }
}
