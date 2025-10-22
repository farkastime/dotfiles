-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<ESC>l", { silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ts", ":TermSelect<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", ":ToggleTermSetName<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>th", "100:TermExec cmd=htop name=htop<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
