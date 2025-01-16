vim.api.nvim_create_user_command("MSFold", function()
  require("microscope.module").fold_except_highlighted()
end, {})

vim.api.nvim_create_user_command("MSUnfold", function()
  require("microscope.module").unfold_all()
end, {})
