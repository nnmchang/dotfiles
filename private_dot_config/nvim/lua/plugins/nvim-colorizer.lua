return { {
  'norcalli/nvim-colorizer.lua',
  opts = { user_default_options = { names = false } },
  config = function(_, opts)
    require 'colorizer'.setup(opts)
  end
} }
