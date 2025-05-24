vim.g.Illuminate_ftblacklist = { 'alpha', 'NvimTree', 'neo-tree', 'dashboard', 'lazy', 'mason' }
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.api.nvim_set_keymap('n', '.', '<cmd>lua require"illuminate".next_reference({wrap=true})<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', ',', '<cmd>lua require"illuminate".next_reference({reverse=true, wrap=true})<cr>', {noremap=true})
