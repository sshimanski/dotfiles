require("nvim-treesitter.configs").setup({
    ensure_installed = 'maintained', -- all
    highlight = {
        enable = true
    },
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
    autopairs = {
        enable = true
    },
    indent = {
        enabled = true
    }
})
