local config = require("chinese-formatter.config").config
local format = require("chinese-formatter.format")

local M = {}

function M.setup(opts)
	config = vim.tbl_deep_extend("force", config, opts or {})

	if config.auto_format_on_save then
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			pattern = "*",
			callback = format.format,
		})
	end

	vim.api.nvim_create_user_command("ChineseFormatterFormat", function()
		format.format()
	end, {})
end

M.format = format.format

return M
