local dap, dapui, dapvt = require("dap"), require("dapui"), require("nvim-dap-virtual-text")
require("plugins.dap.cpp_c_rust")
require("plugins.dap.python")

dapui.setup()
dapvt.setup({
    highlight_changed_variables = true,
    virt_text_win_col = 80
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
