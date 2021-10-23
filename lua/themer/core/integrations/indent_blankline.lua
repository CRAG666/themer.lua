local M = {}

function M.get(cp)

	local hi = {
		IndentBlanklineChar = { fg = cp.gray },
	}

	if require("themer.config").options.integrations.indent_blankline.colored_indent_levels then
		hi["IndentBlanklineIndent6"] = {blend = "nocombine", fg = cp.yellow}
		hi["IndentBlanklineIndent5"] = {blend = "nocombine", fg = cp.red}
		hi["IndentBlanklineIndent4"] = {blend = "nocombine", fg = cp.green}
		hi["IndentBlanklineIndent3"] = {blend = "nocombine", fg = cp.orange}
		hi["IndentBlanklineIndent2"] = {blend = "nocombine", fg = cp.blue}
		hi["IndentBlanklineIndent1"] = {blend = "nocombine", fg = cp.magenta}
	end

	return hi
end

return M
