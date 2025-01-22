# microscope.nvim

A Neovim plugin to focus in on selected code by folding all unhighlighted code, and allow for quick grepping based on cursor position.

## Features

### Fold all surrounding code while keeping the highlighted lines visible.
  - you can use the built in unfold all `zE` to reset
  - Default binding is `<leader>fg` but can be rebound (see below for remapping)

![Folding](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeWtodmNwZmdwazBzMzUxejRoenJzZzZlbHVxa3FkZDR5aWFxanBrbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/d2SrFLxqNGla8Oj4Jz/giphy.gif)

### Live Grep the word at current cursor position
  - Uses Telescope Live Grep
  - Default binding is `<leader>fv` but can be rebound (see below for remapping)

![Grepping](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExNWh4aTI1cDQ4cDVmYzFranVnODVyaWp1bzg1a29janR4MnR1NnAxcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/KVX2Ik198vd35ZASXD/giphy.gif)

## Installation

## Using `lazy.nvim`

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
