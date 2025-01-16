vim.api.nvim_create_user_command("MSFold", function()
  require("microscope.module").fold_except_highlighted()
end, {})
