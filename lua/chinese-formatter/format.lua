local config = require("chinese-formatter.config").config

local M = {}

function M.format()
	if config.space_between_zh_and_en then
		-- 你好hello -> 你好 hello
		vim.cmd([[silent! %s/[^\x00-\xff]\zs\ze[a-zA-Z]\|[a-zA-Z]\zs\ze[^\x00-\xff]/ /g]])
	end

	if config.space_between_zh_and_num then
		-- 你好123 -> 你好 123
		vim.cmd([[silent! %s/[^\x00-\xff]\zs\ze\d\|\d\zs\ze[^\x00-\xff]/ /g]])
	end

	if config.space_between_sym_and_link then
		-- 你好[世界](http://example.com) -> 你好 [世界](http://example.com)
		vim.cmd([[silent! %s/\([^[:space:]!]\)\(\[.*\](.*)\)/\1 \2/g]])
		vim.cmd([[silent! %s/\(\[.*\](.*)\)\(\S\)/\1 \2/g]])
	end

	if config.space_between_sym_and_pic then
		-- 你好![世界](./picture.png) -> 你好 ![世界](./picture.png)
		vim.cmd([[silent! %s/\(\S\)\(\!\[.*\](.*)\)/\1 \2/g]])
		vim.cmd([[silent! %s/\(\!\[.*\](.*)\)\(\S\)/\1 \2/g]])
	end
end

return M
