local M = {}

function M.fold_except_highlighted()
  local cur_buf = vim.api.nvim_get_current_buf()

  -- Get the start and end positions of the visual selection
  local start_pos = vim.api.nvim_buf_get_mark(cur_buf, "<")
  local end_pos = vim.api.nvim_buf_get_mark(cur_buf, ">")

  local start_row, end_row = start_pos[1], end_pos[1] -- 1-based indexing

  -- Ensure fold method is set to manual
  vim.o.foldmethod = "manual"

  -- Fold lines before the selection (if any)
  if start_row > 1 then
    vim.cmd("1," .. start_row - 1 .. "fold")
  end

  -- Fold lines after the selection (if any)
  local total_lines = vim.api.nvim_buf_line_count(cur_buf)
  if end_row < total_lines then
    vim.cmd(end_row + 1 .. "," .. total_lines .. "fold")
  end
end

function M.setup(opts)
  opts = opts or {}
  if opts.keymaps ~= false then
    M.setup_keymaps()
  end
end

return M
