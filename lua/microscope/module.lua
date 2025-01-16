local M = {}

function M.fold_except_highlighted()
  local cur_buf = vim.api.nvim_get_current_buf()

  -- Get the start and end positions of the visual selection
  local start_pos = vim.api.nvim_buf_get_mark(cur_buf, "<")
  local end_pos = vim.api.nvim_buf_get_mark(cur_buf, ">")

  local start_row, end_row = start_pos[1] - 1, end_pos[1] - 1

  -- Ensure fold method is set to manual
  vim.o.foldmethod = "manual"

  -- Open all folds first
  vim.cmd("normal! zR")

  -- Iterate through all lines in the buffer
  local total_lines = vim.api.nvim_buf_line_count(cur_buf)
  for line = 0, total_lines - 1 do
    if line < start_row or line > end_row then
      -- Fold lines outside the selected range
      vim.cmd((line + 1) .. "," .. (line + 1) .. "fold")
    end
  end
end

function M.unfold_all()
  -- Unfold all folds
  vim.cmd("normal! zR")
end

-- Default keymaps
function M.setup_keymaps()
  -- Key mapping for visual mode
  vim.api.nvim_set_keymap(
    "x",
    "<leader>fg",
    ":<C-u>lua require('microscope.module').fold_except_highlighted()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "x",
    "<leader>fv",
    ":<C-u>lua require('microscope.module').unfold_all()<CR>",
    { noremap = true, silent = true }
  )
end

function M.setup(opts)
  opts = opts or {}
  if opts.keymaps ~= false then
    M.setup_keymaps()
  end
end

return M
