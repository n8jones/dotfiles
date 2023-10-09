local km = vim.keymap.set

km("i", "jj", "<Esc>")
km("n", "<leader>tf", "<cmd>Telescope find_files<cr>")
km("n", "<leader>tg", "<cmd>Telescope live_grep<cr>")
km("n", "<leader>tb", "<cmd>Telescope buffers<cr>")
km("n", "<leader>th", "<cmd>Telescope help_tags<cr>")
km("n", "<leader>ts", "<cmd>Telescope lsp_document_symbols<cr>")
km("n", "<leader>tS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
km("n", "<C-p>", "<cmd>bprevious<cr>")
km("n", "<C-n>", "<cmd>bnext<cr>")

km("n", "<C-Space><C-Space>", "<cmd>FloatermToggle<CR>")
km("t", "<C-Space><C-Space>", "<C-\\><C-n>")
