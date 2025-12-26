vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes" -- extra column for warnings before linenum
vim.opt.expandtab = true   --  spaces instead of shifts
vim.opt.shiftwidth = 2     -- 3 spaces indent
vim.opt.tabstop = 2
vim.g.mapleader = " "

require("keymaps")
require("lsp")

vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pairs" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
--  { src = "https://github.com/saghen/blink.cmp",                version = "main" },
}, { confirm = false })

require "mini.pick".setup()
require "mini.pairs".setup()
require "oil".setup()

--[[
require "blink.cmp".setup({
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono'
  },
  completion = { documentation = { auto_show = false } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})
]]

require "nvim-treesitter".setup({
  ensure_installed = { "typst", "ocaml", "bash", "cpp", "rust", "python", "xml" },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
})


vim.cmd("colorscheme vague")
