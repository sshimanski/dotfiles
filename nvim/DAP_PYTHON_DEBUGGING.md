# Neovim DAP Python Debugging Guide

This guide explains how to use the Debug Adapter Protocol (DAP) in Neovim to debug Python applications.

## Prerequisites

1. Install debugpy:
   ```bash
   pip install debugpy
   ```

## Keybindings

The following keybindings are configured for debugging:

### Debugging Controls
- `<F9>` - Continue/Pause execution
- `<F8>` - Step over
- `<F7>` - Step into
- `<S-F8>` - Step out

### Breakpoints
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Set conditional breakpoint

### Debug UI
- `<leader>dd` - Toggle DAP UI
- `<leader>dr` - Open REPL

## Usage

### 1. Setting Breakpoints
Navigate to the line where you want to set a breakpoint and press `<leader>db`.

### 2. Starting Debug Session
- Open a Python file
- Set breakpoints as needed
- Press `<F9>` to start debugging the current file

### 3. Debugging Controls
- Use `<F8>` to step over function calls
- Use `<F7>` to step into functions
- Use `<S-F8>` to step out of functions
- Press `<F9>` again to continue execution until the next breakpoint

### 4. Debugging UI
The DAP UI will automatically open when you start debugging. It includes:
- **Scopes**: Shows local and global variables
- **Breakpoints**: Lists all active breakpoints
- **Stacks**: Shows the call stack
- **Watches**: Allows you to watch specific variables
- **Console**: Interactive Python console

Press `<leader>dd` to toggle the UI visibility.

### 5. REPL
Press `<leader>dr` to open the debug REPL where you can execute Python code in the current debug context.

## Advanced Configuration

### Virtual Environments
The plugin will automatically detect virtual environments. If you need to specify a specific Python interpreter, you'll be prompted when starting a debug session.

### Attaching to Running Process
You can also attach to a running Python process that was started with debugpy:
```bash
python -m debugpy --listen 5678 --wait-for-client your_script.py
```

Then use the "Attach to process" configuration.

## Customization

To customize the debugging configurations, edit `nvim/lua/config/dap-python.lua`.