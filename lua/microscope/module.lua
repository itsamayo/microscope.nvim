local M = {}

function M.fold_except_highlighted()
  -- Get the current visual selection range
  local start_line, _, end_line, _ = unpack(vim.fn.getpos("'<")), unpack(vim.fn.getpos("'>"))
  start_line = math.max(1, start_line)
  end_line = math.min(vim.fn.line("$"), end_line)

  -- Set foldmethod to manual to ensure compatibility
  vim.o.foldmethod = "manual"

  -- Close all folds first
  vim.cmd("silent! normal! zM")

  -- Re-open folds only for the selected range
  for i = start_line, end_line do
    vim.cmd(i .. "foldopen!")
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
