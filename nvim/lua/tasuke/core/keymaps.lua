-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- window management
keymap.set("n", "sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "sh", "<C-w>h", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "sl", "<C-w>l", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "sk", "<C-w>k", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "sj", "<C-w>j", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "ss", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "gj", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "gl", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "gh", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.g.nightflyTransparent = true
-- function _G.set_terminal_keymaps()
--   local opts = { buffer = 0 }
--   vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
-- end
--
-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

keymap.set("n", "x", '"_x')
keymap.set("v", "x", '"_x')
keymap.set("n", "s", '"_s')
keymap.set("v", "s", '"_s')
keymap.set("n", "c", '"_c')
keymap.set("v", "c", '"_c')

keymap.set("i", "<C-y>", "<ESC>o")
keymap.set({ "n", "v" }, ";", "%")
keymap.set("n", "U", "<C-r>")
keymap.set("v", "v", "<C-v>")
keymap.set("i", "jj", "<Esc>")
keymap.set("n", "<Esc><Esc>", ":noh<CR>", { noremap = true, silent = true })

keymap.set({ "n", "v" }, "J", "10j", { noremap = true })
keymap.set({ "n", "v" }, "K", "10k", { noremap = true })
keymap.set({ "n", "v" }, "H", "^", { noremap = true })
keymap.set({ "n", "v" }, "L", "$", { noremap = true })
