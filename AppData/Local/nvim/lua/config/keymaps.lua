-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Move Lines
-- map("v", "<S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- map("v", "<S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Navigation
map({ "n", "v" }, "H", "g0", { desc = "Beginning of line" })
map({ "n", "v" }, "L", "g$", { desc = "End of line" })
map({ "n", "v" }, "J", "<C-d>", { desc = "Jump down half-screen" })
map({ "n", "v" }, "K", "<C-u>", { desc = "Jump up half-screen" })

-- Code
map({ "n", "v" }, "gJ", "J:echo 'gJ: Lines joined'<CR>", { desc = "Join lines, remap for <S-J>" })
map({ "n", "v" }, "gj", ":echo 'gj: Use gJ instead to join lines'<CR>", { desc = "Use gJ to join lines" })

-- Buffers
map("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<A-j>", "")
map("n", "<A-k>", "")
