# microscope.nvim

A Neovim plugin to focus in on selected code by folding all unhighlighted code.

### Unfocused

![Screenshot 2025-01-16 at 5 36 10 PM](https://github.com/user-attachments/assets/4599b5d5-c106-44ce-9a27-8dd312e71e62)

### Focused

![Screenshot 2025-01-16 at 5 27 34 PM](https://github.com/user-attachments/assets/57c639f0-f368-44ca-bddb-e14bb4ca18f5)

## Features

- Fold all surrounding code while keeping the highlighted lines visible.
  - Uses built in unfold all in normal mode: `zE`
  - Default binding is `<leader>fg` but can be rebound (see below for remapping)
- Live Grep the word at current cursor position
  - Default binding is `<leader>fv` but can be rebound (see below for remapping)
- Supports multiple languages via Neovim's Tree-sitter integration.

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
            fold = "<leader>fg", --replace fg with your preferred mapping
            grep = "<leader>fv" -- replace fv with your preferred mapping
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
