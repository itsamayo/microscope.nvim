# microscope.nvim

A Neovim plugin to focus in on selected code by folding all unhighlighted code.

## Features

- Fold all surrounding code while keeping the highlighted lines visible.
- Supports multiple languages via Neovim's Tree-sitter integration.
- Easy-to-use default key mappings:
  - `:MSFold`: Fold surrounding code. Default binding is `<leader>fg` but can be rebound
  - Use built in Neovim unfold all in normal mode: `zE`

## Installation

### Using `lazy.nvim`

Add the following to your `lazy.nvim` configuration:

```lua
{
  "itsamayo/microscope.nvim",
    config = function()
      require("microscope.module").setup {
        -- This is optional, fg is the default, replace fa with your desired binding
        -- Note that this is in visual mode
        keymaps = {
          fold = "<leader>fa",
        },
      }
    end,
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
