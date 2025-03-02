-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })    -- make split windows equal width & height

-- better ctrl u/d
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up half a page" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half a page" })
