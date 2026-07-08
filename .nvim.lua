local dap = require("dap")

local dap_cortex_debug = require("dap-cortex-debug")
dap_cortex_debug.setup({})

dap.configurations.c = {
    {
        name = 'Example debugging with OpenOCD',
        type = 'cortex-debug',
        request = 'launch',
        servertype = 'openocd',
        serverpath = 'openocd',
        gdbPath = 'arm-none-eabi-gdb',
        toolchainPath = '/Users/gasc/src-install/arm-none-eabi-10.3/bin',
        toolchainPrefix = 'arm-none-eabi',
        runToEntryPoint = 'main',
        swoConfig = { enabled = false },
        showDevDebugOutput = false,
        gdbTarget = 'localhost:3333',
        cwd = '${workspaceFolder}',
        executable = '${workspaceFolder}/build/out',
        configFiles = {
            "interface/stlink.cfg",
            "target/stm32f4x.cfg"
        },
        rttConfig = {
            address = 'auto',
            decoders = {
                {
                    label = 'RTT:0',
                    port = 0,
                    type = 'console'
                }
            },
            enabled = true
        }
    }
}
