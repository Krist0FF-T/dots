
-- bullet-point journal directory
local log_dir = vim.fn.expand("~/Documents/exobrain/log/")

local namespace = vim.api.nvim_create_namespace("exobrain")

local function jump_to_present()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    -- vim.fn.system("notify-send log 'jumping to present'")

    for i, line in ipairs(lines) do
        if vim.trim(line) == "---" then
            vim.api.nvim_win_set_cursor(0, { i, 100 })
        end
    end
end

local function show_weekdays()
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    -- vim.fn.system("notify-send log 'showing weekdays'")
    local today = os.date("%Y-%m-%d")

    local last_week = nil
    for i, line in ipairs(lines) do
        local date = line:match("^(# %d%d%d%d%-%d%d%-%d%d)$")
        if date then
            local year, month, day = date:match("(%d+)-(%d+)-(%d+)")

            local timestamp = os.time({
                year = year,
                month = month,
                day = day,
            })

            local weekday = os.date("%a", timestamp)
            local week_num = os.date("%V", timestamp)

            local comment = weekday .. (week_num ~= last_week and ", w" .. week_num or "")

            vim.api.nvim_buf_set_extmark(0, namespace, i-1, string.len(line), {
                virt_text = {
                    { " (" .. comment .. ")", "Comment" },
                },
                virt_text_pos = "inline"
            })

            last_week = week_num
        end
    end
end

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = log_dir .. "*.md",
    callback = function()
        local opts = { buffer = true, silent = true }
        -- vim.fn.system("notify-send log entered")

        jump_to_present()
        show_weekdays()

        -- vim.keymap.set("n", "<leader>la", function()
        --     vim.fn.system("notify-send log add")
        -- end, opts)

        vim.keymap.set("n", "<leader>lt", function()
            -- vim.fn.system("notify-send log today")
            jump_to_present()
        end, opts)

        -- vim.keymap.set("n", "<leader>lj", function()
        --     vim.fn.system("notify-send log jump")
        -- end, opts)

        vim.keymap.set("n", "<leader>lw", function()
            show_weekdays()
        end, opts)
    end,
})

