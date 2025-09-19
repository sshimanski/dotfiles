local Job = require("plenary.job")

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand "%:t") == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

-- Source: 🔭 utils: https://git.io/JK3ht
function M.get_os_command_output(cmd, cwd)
    if type(cmd) ~= "table" then
        print "Utils: [get_os_command_output]: cmd has to be a table"
        return {}
    end

    local command = table.remove(cmd, 1)
    local stderr = {}

    local stdout, ret = Job:new({
            command = command,
            args = cmd,
            cwd = cwd,
            on_stderr = function(_, data)
                table.insert(stderr, data)
            end,
        })
        :sync()
    return stdout, ret, stderr
end

M.dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "Nvim LUA configs",
        cwd = '~/dotfiles/nvim',
        hidden = true,
    })
end

M.project_files = function()
    local _, ret, _ = M.get_os_command_output {
        "git",
        "rev-parse",
        "--is-inside-work-tree",
    }

    if ret == 0 then
        require("telescope.builtin").git_files()
    else
        local fopts = {}
        fopts.results_title = "CWD: " .. vim.fn.getcwd()

        require("telescope.builtin").find_files(fopts)
    end
end

M.buf_set_keymap = function(bufnr, mode, mapping, command)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, mode, mapping, command, opts)
end

-- TODO vim.inspect?
M.dump = function(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

return M
