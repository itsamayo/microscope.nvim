local M = {}
local function get_visual_selection()
  -- Get current buffer
  local cur_buf = vim.api.nvim_get_current_buf()

  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Convert from 1-based line and column to Lua's 1-based indexing
  local start_row, end_row = start_pos[2], end_pos[2]

  return cur_buf, start_row, end_row
end

function M.fold_except_highlighted()
  -- Ensure fold method is manual
  vim.o.foldmethod = "manual"

  -- Get fresh visual selection
  local cur_buf, start_row, end_row = get_visual_selection()

  -- Fold lines before the selection
  if start_row > 1 then
    vim.cmd("1," .. (start_row - 1) .. "fold")
  end

  -- Fold lines after the selection
  local total_lines = vim.api.nvim_buf_line_count(cur_buf)
  if end_row < total_lines then
    vim.cmd((end_row + 1) .. "," .. total_lines .. "fold")
  end

  -- Clear visual mode to reset any lingering marks
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
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
