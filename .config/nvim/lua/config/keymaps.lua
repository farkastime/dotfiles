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

local runner = require("quarto.runner")
vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set("n", "<leader>RA", function()
  runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })
