vim.api.nvim_create_user_command("MSFold", require("microscope.module").fold_excep_highlighted, {})
vim.api.nvim_create_user_command("MSUnfold", require("microscope.module").unfold_all, {})
