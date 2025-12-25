require("keymaps")
require("lsp")

vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes" -- extra column for warnings before linenum
vim.opt.expandtab = true  --  spaces instead of shifts
vim.opt.shiftwidth = 2    -- 3 spaces indent
vim.opt.tabstop = 2
vim.g.mapleader = " "


vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pairs" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
})

require "mini.pick".setup()
require "mini.pairs".setup()
require "oil".setup()

vim.cmd("colorscheme vague")
