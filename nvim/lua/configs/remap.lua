-- <leader> key
vim.g.mapleader = " ";

-- Navigation
vim.keymap.set("n", "<leader>nv", vim.cmd.Ex)

-- Delete into void instead of cpy buffer
vim.keymap.set("x", "<leader>p", "\"_dP");
vim.keymap.set("n", "<leader>d", "\"_d");
vim.keymap.set("v", "<leader>d", "\"_d");

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y");
vim.keymap.set("v", "<leader>y", "\"+y");


-- Insert mode with indentation
vim.keymap.set('n', "i", function()
    return string.match(vim.api.nvim_get_current_line(), '%g') == nil and "cc" or 'i'
end, { expr = true, noremap = true });

-- Window management
vim.keymap.set('n', "<Up>", "<C-W>k", { desc = "Move to to the window above" });
vim.keymap.set('n', "<Down>", "<C-W>j", { desc = "Move to the window below" });
vim.keymap.set('n', "<Left>", "<C-W>h", { desc = "Move to the window to the left" });
vim.keymap.set('n', "<Right>", "<C-W>l", { desc = "Move to the window to the right" });
-- <leader>N #Go to buffer index N
for i = 1, 9 do -- Only keymap 1-9
    local lhs = "<leader>" .. tostring(i);
    local rhs = tostring(i) .. "<C-W>w";
    vim.keymap.set('n', lhs, rhs, { desc = "Move to window " .. tostring(i) });
end

-- Marking
vim.keymap.set('n', "<C-a>", "ggVG", { desc = "Select everything from normal mode" });
