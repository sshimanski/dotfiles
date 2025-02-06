local adapters = { "python" } --list your adapters here

for _, adapter in ipairs(adapters) do
    require("plugins.dap.adapters." .. adapter)
end

require('dap').defaults.fallback.external_terminal = {
    command = '/usr/bin/alacritty',
    args = { '-e' },
}
