return {
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    opts = {},
    config = function() require 'lsp_signature'.on_attach() end
  }
}
