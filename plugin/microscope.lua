vim.api.nvim_create_user_command("MSFold", function()
  require("microscope.module").fold_except_highlighted()
end, {
  desc = "Microscope: fold all lines except the highlighted range",
})
