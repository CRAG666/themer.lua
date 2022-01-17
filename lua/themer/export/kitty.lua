---@export kitty config
---@export_method write in a buffer
---@author narutoxy

---@class kitty
local kitty = {}

---@param hl_name string hig group name
---@param value string foreground/background
---@return string hex value
local color_from_hl = function(hl_name, value)
    local hl = vim.api.nvim_get_hl_by_name(hl_name, true)
    local color = string.format("#%x", hl[value] or 0)
    return color
end

kitty.scrape_current_scheme = function()
    local c = {}
    c.foreground = color_from_hl("Normal", "foreground")
    c.background = color_from_hl("Normal", "background")
    for i = 0, 15 do
        c["color" .. i] = vim.g["terminal_color_" .. i]
    end
    c.cursor = color_from_hl("Cursor", "background") or c.foreground
    c.cursor_text_color = color_from_hl("Cursor", "foreground") or c.background
    c.url_color = color_from_hl("ThemerURI", "foreground")
    c.selection_foreground = color_from_hl("Visual", "foreground")
    c.selection_background = color_from_hl("Visual", "background")
    c.tab_bar_background = color_from_hl("TabLine", "background")
    c.active_tab_foreground = color_from_hl("ThemerSelected", "foreground")
    c.active_tab_background = color_from_hl("ThemerSelected", "background")
    c.inactive_tab_foreground = color_from_hl("ThemerDimmedFloat", "foreground")
    c.inactive_tab_background = color_from_hl("ThemerDimmedFloat", "background")
    c.active_border_color = color_from_hl("ThemerBorder", "foreground")
    c.inactive_border_color = color_from_hl("VertSplit", "foreground")

    return c
end

kitty.generate_kitty_config = function()
    local config = { "# Put the following lines in your kitty.conf", "# Generated by Themer" }
    for setting_name, setting_value in pairs(kitty.scrape_current_scheme()) do
        table.insert(config, setting_name .. " " .. string.upper(setting_value))
    end
    return config
end

kitty.write_config = function()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(buf, "Kitty")
    vim.api.nvim_buf_set_lines(buf, 0, 1, true, kitty.generate_kitty_config())
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "readonly", true)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "filetype", "conf")
    vim.api.nvim_exec("buffer " .. buf, false)
end

return kitty
