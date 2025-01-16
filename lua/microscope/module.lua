local M = {}

function M.fold_except_highlighted()
  local cur_buf = vim.api.nvim_get_current_buf()

  -- Ensure we're operating in visual mode
  if vim.fn.mode() ~= "v" and vim.fn.mode() ~= "V" then
    vim.notify("This function must be used in visual mode.", vim.log.levels.WARN)
    return
  end

  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<") -- Start mark
  local end_pos = vim.fn.getpos("'>") -- End mark

  -- Convert marks to 1-based line numbers
  local start_row = start_pos[2]
  local end_row = end_pos[2]

  -- Ensure fold method is set to manual
  vim.o.foldmethod = "manual"

  -- Fold lines before the selection (if any)
  if start_row > 1 then
    vim.cmd(start_row - 1 .. "fold")
  end

  -- Fold lines after the selection (if any)
  local total_lines = vim.api.nvim_buf_line_count(cur_buf)
  if end_row < total_lines then
    vim.cmd(end_row + 1 .. "," .. total_lines .. "fold")
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
