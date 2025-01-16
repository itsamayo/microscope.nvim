vim.api.nvim_create_user_command("MSFold", require("microscope").fold_excep_highlighted, {})
vim.api.nvim_create_user_command("MSUnfold", require("microscope").unfold_all, {})
