local map = vim.keymap.set
local dismap = vim.keymap.del

-- normal
map("n", ";", ":")
dismap("n", "S")
map("n", "S", "<cmd>w<CR>")
map("n", "Q", "<cmd>q<CR>")
map("n", "K", "5k")
map("n", "J", "5j")
map("i", "jj", "<ESC>", { desc = "Escape insert mode" })

-- tabs
map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<S-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>e", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Comment
map("n", "<leader>c/", "<cmd>normal gcc<cr>fa<bs>", { desc = "Add Comment " })
