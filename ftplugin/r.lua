
vim.api.keymap('n', '<leader>rp', ':!Rscript -e "rmarkdown::render(\'%\')"', { noremap = true, silent = true })
