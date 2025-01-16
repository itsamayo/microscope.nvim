# microscope.nvim

A Neovim plugin to focus in on selected code by folding all unhighlighted code.

## Features

- Fold all surrounding code while keeping the highlighted lines visible.
- Supports multiple languages via Neovim's Tree-sitter integration.
- Easy-to-use default key mappings:
  - `<leader>fg`: Fold surrounding code.
  - `<leader>fv`: Unfold all code.

## Installation

### Using `lazy.nvim`

Add the following to your `lazy.nvim` configuration:

```lua
{
  "itsamyo/microscope.nvim",
  config = function()
    require("micropscope").setup()
  end
}
```

### Using `packer.nvim`

Add the following to your `packer.nvim` configuration:

```lua
use {
  "itsamayo/microscope.nvim",
  config = function()
    require("microscope").setup()
  end
}

```
