-- one might even call it a coloRIZZER xD
-- (my humor's absolutely broken)

-- #ff0000

return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        mode = "virtualtext",
    },
}

-- return {
--     "echasnovski/mini.hipatterns",
--     config = function()
--         local hip = require "mini.hipatterns"
--         hip.setup {
--             highlighters = {
--                 hex_color = hip.gen_highlighter.hex_color(),
--             }
--         }
--     end
-- }
