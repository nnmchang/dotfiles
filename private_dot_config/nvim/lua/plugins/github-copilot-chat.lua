function ShowCopilotChatActionPrompt()
  local actions = require "CopilotChat.actions"
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = not vim.g.vscode,
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    -- opts = {
    --   debug = true, -- Enable debugging
    -- },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      {
        "<leader>ccp",
        "<cmd>lua ShowCopilotChatActionPrompt()<cr>",
        noremap = true,
        silent = true,
      },
    },
  },
}
