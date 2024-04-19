require "nvchad.mappings"

-- add yours here
if not vim.g.vscode then
  local map = vim.keymap.set

  map("n", ";", ":", { desc = "CMD enter command mode" })
  map("i", "jk", "<ESC>")
end

if vim.g.vscode then
  local keymap = vim.api.nvim_set_keymap
  local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
  end

  keymap("n", "<Leader>fa", notify "workbench.action.findInFiles", { silent = true }) -- use ripgrep to search files
  keymap("n", "<Leader>ff", notify "workbench.action.quickOpen", { silent = true }) -- open file ff
  keymap("n", "<Leader>ra", notify "editor.action.rename", { silent = true }) -- save file
  keymap("n", "<Leader>fm", notify "editor.action.formatDocument", { silent = true }) -- save all files
end
