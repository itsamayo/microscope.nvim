# microscope.nvim

A Neovim plugin to focus in on selected code by folding all unhighlighted code.

## Features

- Fold all surrounding code while keeping the highlighted lines visible.
  - Uses built in unfold all in normal mode: `zE`
  - Default binding is `<leader>fg` but can be rebound (see below for remapping)

![Folding](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZjAzbHA0Znc2ZTNjeXVoZXE5NmV6YWZwbGtzMGt6ZGtjanE0NHFiMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/P4sqVRhSN1FBMbZ6EB/giphy.gif)

- Live Grep the word at current cursor position
  - Default binding is `<leader>fv` but can be rebound (see below for remapping)
  - Uses Telescope Live Grep
- Supports multiple languages via Neovim's Tree-sitter integration.

![Grepping](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExN3N2bmt5dG5qcnJzY3BiMXU2ZzNqZHJkbjgxMjFobGh0eDczbGxqYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/5q4NoYK8zFsMbV9PEM/giphy.gif)

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
