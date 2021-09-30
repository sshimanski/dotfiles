local M = {}

M.dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = '~/dotfiles/nvim',
        hidden = true,
    })
end

return M
