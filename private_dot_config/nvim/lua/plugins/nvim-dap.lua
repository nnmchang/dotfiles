local is_windows = vim.fn.has("win32") == 1
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<Leader>dap", function() require("dapui").toggle() end },
      { '<F5>',        ':DapContinue<CR>',                                                                         { silent = true } },
      { '<F10>',       ':DapStepOver<CR>',                                                                         { silent = true } },
      { '<F11>',       ':DapStepInto<CR>',                                                                         { silent = true } },
      { '<F12>',       ':DapStepOut<CR>',                                                                          { silent = true } },
      { '<F9>',        ':DapToggleBreakpoint<CR>',                                                                 { silent = true } },
      { '<leader>B',   ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true } },
      { '<leader>lp',  ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',    { silent = true } },
      { '<leader>dr',  ':lua require("dap").repl.open()<CR>',                                                      { silent = true } },
      { '<leader>dl',  ':lua require("dap").run_last()<CR>',                                                       { silent = true } },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      require("dap.ext.vscode").load_launchjs(nil, { debugpy = { "python" } })
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      -- https://www.lazyvim.org/extras/lang/python#nvim-dap-python
      local mason_reg = require("mason-registry")
      local debugpy = mason_reg.get_package("debugpy")
      local debugpy_path = debugpy:get_install_path()
      local debugpy_venv = debugpy_path .. "/venv"
      if is_windows then
        debugpy_venv = debugpy_venv .. "/Scripts/python"
      else
        debugpy_venv = debugpy_venv .. "/bin/python"
      end
      require("dap-python").setup(debugpy_venv)
    end,
  },
}
