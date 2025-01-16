local M = {}
local util = require("vim.lsp.util")

function M.fold_except_highlighted()
  local cur_buf = vim.api.nvim_get_current_buf()

  -- Ensure fold method is set to manual
  vim.o.foldmethod = "manual"

  -- Get the visual selection range using LSP utilities
  local range_params = util.make_given_range_params(nil, nil, cur_buf)
  if not range_params or not range_params.range then
    vim.notify("Could not determine visual selection range.", vim.log.levels.ERROR)
    return
  end

  local start_row = range_params.range.start.line + 1 -- Convert 0-based to 1-based
  local end_row = range_params.range["end"].line + 1 -- Convert 0-based to 1-based

  -- Fold lines before the selection
  if start_row > 1 then
    vim.cmd("1," .. (start_row - 1) .. "fold")
  end

  -- Fold lines after the selection
  local total_lines = vim.api.nvim_buf_line_count(cur_buf)
  if end_row < total_lines then
    vim.cmd((end_row + 1) .. "," .. total_lines .. "fold")
  end
end

-- Default keymaps
function M.setup_keymaps(keymaps)
  keymaps = keymaps or {}

  -- Default keymap for visual mode to fold
  vim.api.nvim_set_keymap(
    "x",
    keymaps.fold or "<leader>fg", -- Allow user to specify their own keymap
    ":<C-u>lua require('microscope.module').fold_except_highlighted()<CR>",
    { noremap = true, silent = true, desc = "Microscope: fold all lines except the highlighted range" }
  )
end

function M.setup(opts)
  opts = opts or {}

  -- Set up keymaps only if they aren't disabled
  if opts.keymaps ~= false then
    M.setup_keymaps(opts.keymaps) -- Use the keymaps passed in the options
  end
end

return M
