local M = {}

-- https://github.com/PanicKk/nvim-base16.lua/blob/master/lua/hl_themes/monokai.lua
M.base_30 = {
   white = "#f8f8f2",
   darker_black = "#21221c",
   black = "#272822", --  nvim bg
   black2 = "#2d2e28",
   one_bg = "#31322c", -- real bg of onedark
   one_bg2 = "#3a3b35",
   one_bg3 = "#42433d",
   grey = "#4f504a",
   grey_fg = "#595a54",
   grey_fg2 = "#63645e",
   light_grey = "#6b6c66",
   red = "#f92672",
   baby_pink = "#ff3581",
   pink = "#fd5ffe",
   line = "#363731", -- for lines like vertsplit
   green = "#a6e22e",
   vibrant_green = "#bffb47",
   nord_blue = "#59cce2",
   blue = "#66d9ef",
   yellow = "#e6db74",
   sun = "#eee37c",
   purple = "#ae81ff",
   dark_purple = "#9f72f0",
   teal = "#4dc0d6",
   orange = "#fd971f",
   cyan = "#a1efe4",
   statusline_bg = "#2b2c26",
   lightbg = "#383933",
   lightbg2 = "#32332d",
   pmenu_bg = "#A3BE8C",
   folder_bg = "#61afef",
}

-- https://github.com/PanicKk/nvim-base16.lua/blob/master/lua/themes/monokai-base16.lua
M.base_16 = {
    base00 = "#272822",
    base01 = "#383830",
    base02 = "#49483e",
    base03 = "#75715e",
    base04 = "#a59f85",
    base05 = "#f8f8f2",
    base06 = "#f5f4f1",
    base07 = "#f9f8f5",
    base08 = "#f92672",
    base09 = "#fd971f",
    base0A = "#f4bf75",
    base0B = "#a6e22e",
    base0C = "#a1efe4",
    base0D = "#66d9ef",
    base0E = "#ae81ff",
    base0F = "#cc6633"
}

M.type = "dark" -- light / dark

-- M = require("base46").override_theme(M, "abc")

return M
