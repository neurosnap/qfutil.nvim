if vim.g.loaded_qfutil then
  return
end
vim.g.loaded_qfutil = true

vim.api.nvim_create_user_command("Qfa", function(props)
	require("qfutil").cqf({ cmd = props.args, auto_jump = true })
end, { nargs = "+", desc = "convert system command to quickfix and auto jump to first result" })

vim.api.nvim_create_user_command("Qf", function(props)
	require("qfutil").cqf({ cmd = props.args, auto_jump = false })
end, { nargs = "+", desc = "convert system command to quickfix" })
