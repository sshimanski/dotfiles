local M = {}

M.dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "nvim Lua configs",
        cwd = '~/dotfiles/nvim',
        hidden = true,
    })
end

return M
