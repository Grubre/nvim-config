-- Small, plugin-agnostic wrapper for controlled vim.pack activation.
local M = {}

local loaded = {}

local function packadd(name, bang)
    vim.cmd.packadd({ name, bang = bang, magic = { file = false } })
end

function M.add(specs, opts)
    opts = opts or {}

    local startup = {}
    for _, name in ipairs(opts.startup or {}) do
        startup[name] = true
    end

    vim.pack.add(specs, {
        load = function(plugin)
            if startup[plugin.spec.name] then
                -- Add startup plugins to the runtime path now. Neovim will
                -- source their plugin scripts later in its normal startup.
                packadd(plugin.spec.name, true)
            end
        end,
    })
end

function M.load(name)
    if loaded[name] then
        return
    end

    packadd(name, false)
    loaded[name] = true
end

function M.require(plugin, module)
    M.load(plugin)
    return require(module or plugin)
end

function M.defer(delay, callback)
    local function schedule()
        vim.defer_fn(callback, delay)
    end

    if vim.v.vim_did_enter == 1 then
        schedule()
        return
    end

    vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = schedule,
    })
end

return M
