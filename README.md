# microscope.nvim

A Neovim plugin to focus in on selected code by folding all unhighlighted code, and allow for quick grepping based on cursor position.

## Features

### Fold all surrounding code while keeping the highlighted lines visible.
  - You can use the built in unfold all `zE` to reset
  - Default binding is `<leader>fg` but can be rebound (see below for remapping)

https://github.com/user-attachments/assets/d3c45023-dd7d-451d-9cf5-833b5d3ac61a

### Live Grep the word at current cursor position
  - Uses Telescope Live Grep
  - Default binding is `<leader>fv` but can be rebound (see below for remapping)

https://github.com/user-attachments/assets/f9e06fe6-b2ce-410b-bb62-c6ffc7b624ff

## Installation

## Using `lazy.nvim`

Add the following to your `lazy.nvim` configuration:

```lua
{
  "itsamayo/microscope.nvim",
    config = function()
      require("microscope.module").setup {
        -- This is optional, replace fg/fv with your desired bindings
        keymaps = {
            fold = "<leader>fg", --replace fg with your preferred mapping -- visual mode
            grep = "<leader>fv" -- replace fv with your preferred mapping -- normal mode
        },
      }
    end,
}
```

## Using `packer.nvim`

Add the following to your `packer.nvim` configuration:

```lua
use {
  "itsamayo/microscope.nvim",
  config = function()
    require("microscope").setup()
  end
}

```
