-- space bar leader key
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>b", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- lazy sync
vim.keymap.set("n", "<leader>ls", ":Lazy sync<cr>")

-- plugins keymaps:

-- telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- markdown preview
vim.keymap.set("n", "<leader>m", ":MarkdownPreviewToggle<cr>")

-- command
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":wq<cr>")

local modes = { "n", "i", "v", "x", "o", "c", "t" }
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }

vim.keymap.set("n", "<leader>o", function()
	require("oil").open()
end, { desc = "Open Oil" })

for _, m in ipairs(modes) do
	for _, key in ipairs(arrows) do
		vim.keymap.set(m, key, "<Nop>", { noremap = true, silent = true })
	end
end

vim.keymap.set("n", "<leader>rd", function()
	vim.cmd("w")
	vim.cmd("!g++ % -DREZE -std=c++17 -O2 -Wall -o %:r.out && ./%:r.out")
end, { desc = "Debug run (REZE)" })
