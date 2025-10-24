-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<esc>l", { silent = true })

-- Terminal menu keybindings
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<leader>tt", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ts", ":TermSelect<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<leader>ts", "<C-\\><C-n>:TermSelect<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", ":ToggleTermSetName<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tb", "100:TermExec cmd=btop name=btop<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-n>", "<C-\\><C-n>", { noremap = true, silent = true })
