local toggle_zen = function()
  local zen_mode = require "zen-mode"
  zen_mode.toggle({
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
        laststatus = 0,
      },
    }
  })
end
return {
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>zn",
        toggle_zen,
      },
    },
  },
}
