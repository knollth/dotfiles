vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes" -- extra column for warnings before linenum

vim.opt.winborder = "rounded"

vim.opt.swapfile = false
vim.opt.tabstop = 3 -- display 1 tab ('\t') as 3 spaces
-- vim.opt.expandtab = true  --  spaces instead of shifts
-- vim.opt.shiftwidth = 3    -- 3 spaces indent

vim.g.mapleader = " "


vim.opt.completeopt:append('noselect') -- show completion menu but don't automatically select first item, for lsp autocomplete (see lua/lsp.lua)
