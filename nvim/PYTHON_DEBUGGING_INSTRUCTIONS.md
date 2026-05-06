# How to Debug Python Code with Neovim DAP

## Setup Complete

Your Neovim configuration now includes:
- nvim-dap for debugging support
- nvim-dap-ui for a visual debugging interface
- nvim-dap-python for Python-specific debugging
- Telescope integration for debugging commands
- Keybindings for common debugging operations

## Required Dependencies

Make sure you have debugpy installed:
```
pip3 install debugpy
```

## How to Debug Python Code

1. **Open a Python file** in Neovim:
   ```
   nvim test_debug.py
   ```

2. **Set a breakpoint** by navigating to a line and pressing:
   ```
   <leader>db
   ```
   (By default, `<leader>` is `,` in your configuration)

3. **Start debugging** by pressing:
   ```
   <F9>
   ```
   This will launch the current file with the Python debugger.

4. **Navigate through code** using:
   - `<F8>`: Step over
   - `<F7>`: Step into
   - `<S-F8>`: Step out
   - `<F9>`: Continue until next breakpoint

5. **View debugging interface** by pressing:
   ```
   <leader>dd
   ```
   This toggles the DAP UI which shows variables, breakpoints, call stack, etc.

6. **Open debug console** by pressing:
   ```
   <leader>dr
   ```
   This opens the REPL where you can execute Python code in the current debug context.

## Debugging Configurations

The following debugging configurations are available:
1. **Launch file**: Runs the current Python file
2. **Launch module**: Runs a specific Python module
3. **Attach to process**: Connects to a running Python process with debugpy

## Example Debugging Session

1. Open the test file:
   ```
   nvim ~/dotfiles/nvim/test_debug.py
   ```

2. Set a breakpoint on line 10 (`print(f"fibonacci({i}) = {fibonacci(i)}")`) by pressing `,db`

3. Start debugging by pressing `F9`

4. The debugger will stop at your breakpoint. Use:
   - `F8` to step over the print statement
   - `F7` to step into the fibonacci function
   - `F9` to continue execution

5. Toggle the debugging UI with `,dd` to see variables and the call stack.

## Customizing Python Paths

If you need to specify a specific Python interpreter, you'll be prompted when starting a debug session. You can also modify the configuration in:
```
~/dotfiles/nvim/lua/config/dap-python.lua
```

## Troubleshooting

If debugging doesn't start:
1. Check that debugpy is installed: `python3 -c "import debugpy; print('OK')"`
2. Verify the Python path in the configuration
3. Ensure no other debug sessions are running on the same port