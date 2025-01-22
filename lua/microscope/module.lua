local M = {}
local function get_visual_selection()
  -- Get current buffer
  local cur_buf = vim.api.nvim_get_current_buf()

  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Convert from Vim's 1-based indexing
  local start_row = math.min(start_pos[2], end_pos[2])
  local end_row = math.max(start_pos[2], end_pos[2])

  return cur_buf, start_row, end_row
end

function M.fold_except_highlighted()
  -- Ensure fold method is set to manual
  vim.o.foldmethod = "manual"

  -- Get the visual selection range
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

  -- Clear the visual selection (if necessary)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
end

-- Helper to get the word under the cursor
local function get_word_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Adjust to Lua's 1-based indexing

  -- Start looking for the start and end of the word
  local start_idx = line:sub(1, col):find("%w+$") -- Find the last word ending at or before the cursor
  local end_idx = line:find("%W", col) or (#line + 1) -- Find the first non-word character after the cursor

  if start_idx then
    return line:sub(start_idx, end_idx - 1)
  end

  return nil
end

-- Command to copy the word and open live grep
function M.grep_word_under_cursor()
  -- Get the word under the cursor
  local word = get_word_under_cursor()
  if not word then
    print("No word under the cursor")
    return
  end

  -- Use Telescope's live grep with pre-filled input
  local ok, telescope_builtin = pcall(require, "telescope.builtin")
  if not ok then
    print("Telescope is not installed")
    return
  end

  telescope_builtin.live_grep({ default_text = word })
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

  -- Default keymap for grepping word under cursor
  vim.api.nvim_set_keymap(
    "n",
    keymaps.grep or "<leader>fv",
    ":lua require('microscope.module').grep_word_under_cursor()<CR>",
    { noremap = true, silent = true, desc = "Microscope: live grep word under cursor" }
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
