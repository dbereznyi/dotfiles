local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.6', 
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  "williamboman/mason.nvim",
  "lewis6991/gitsigns.nvim",
  "rebelot/kanagawa.nvim",
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  "prisma/vim-prisma",
  "sbdchd/neoformat",
  "jparise/vim-graphql",
})

require("mason").setup()

require("kanagawa").setup({
  keywordStyle = { italic = false },
  -- transparent = true,
  overrides = function(colors)
    return {
      LineNr = { bg = colors.palette.sumiInk0 },
      StatusLine = { bg = colors.palette.sumiInk0, fg = colors.palette.dragonWhite },
      StatusLineNC = { bg = colors.palette.sumiInk1, fg = colors.palette.dragonWhite },
      TabLine = { bg = colors.palette.dragonBlack1, fg = colors.palette.lotusWhite1 },
      TabLineSel = { bg = colors.palette.sumiInk0, fg = colors.palette.dragonWhite },
      TabLineFill = { bg = "none" },
    }
  end
})

require("typescript-tools").setup({
    settings = {
        complete_function_calls = true,
    }
})

-- Colorscheme

vim.cmd("colorscheme kanagawa")

-- Telescope

local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_strategy = "flex",
  },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.cmd("hi TelescopeBorder ctermfg=123")

-- LSP

vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>e", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>j", vim.lsp.buf.implementation, {})


-- Run prettier on save (for JS/TS files)
vim.cmd([[
  let g:neoformat_try_node_exe = 1
  autocmd BufWritePre *.js Neoformat
  autocmd BufWritePre *.ts Neoformat
  autocmd BufWritePre *.tsx Neoformat
]])
