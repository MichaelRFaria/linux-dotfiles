vim.opt.clipboard = "unnamedplus"

-- copy selected text to the system clipboard
-- note: Ctrl + C still interrupts Insert mode, but no longer works for Visual Mode - use Esc for interruption as it interrupts both Visual and Insert mode
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- paste from system clipboard
-- note: Replaces shortcut for Visual Block mode - use Ctrl + Q for Visual Block mode
vim.keymap.set({ "n", "v", "i" }, "<C-v>", function()
    if vim.fn.mode() == "i" then
        return "<C-r>+"
    end

    return '"+p'
end, { expr = true, desc = "Paste" })
