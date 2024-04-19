return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason").setup()
      require("mason-nvim-dap").setup {
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      }
    end,
  },
}
