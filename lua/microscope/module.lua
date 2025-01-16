local M = {}

-- Fold all code except highlighted
function M.fold_except_highlighted()
  vim.cmd("normal! zR") -- Open all folds first
  local cur_buf = vim.api.nvim_get_current_buf()
  local start_pos = vim.api.nvim_buf_get_mark(cur_buf, "<")
  local end_pos = vim.api.nvim_buf_get_mark(cur_buf, ">")

  local start_row, end_row = start_pos[1] - 1, end_pos[1] - 1

  for line = 0, vim.api.nvim_buf_line_count(cur_buf) - 1 do
    if line < start_row or line > end_row then
      vim.fn.setfoldlevel(line + 1, 0) -- Fold lines outside the visual range
    end
  end
end

-- Unfold all
function M.unfold_all()
  vim.cmd("normal! zR") -- Unfold everything
end

-- Default keymaps
function M.setup_keymaps()
  vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    ":lua require('microscope.module').fold_except_highlighted()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>fv",
    ":lua require('microscope.module').unfold_all()<CR>",
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
