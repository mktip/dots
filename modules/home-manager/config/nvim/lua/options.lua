local M = {}

M.config = function()
  -- permanent history
  vim.opt.undofile = true
  vim.opt.backupcopy = 'yes'

  vim.g.mapleader = " "

  vim.opt.termguicolors = true

  vim.cmd("set foldopen-=block")
  vim.cmd("set formatoptions-=j")

  vim.opt.foldmethod = "marker"

  vim.opt.splitbelow = true
  vim.opt.splitright = true

  vim.opt.textwidth = 120
  vim.opt.winwidth = 120

  vim.opt.timeoutlen = 500
  vim.opt.laststatus = 3
  vim.opt.showtabline = 1
  vim.opt.cursorline = false
  vim.opt.winheight = 5
  vim.opt.winminheight = 5

  vim.opt.wildmode = "longest,list"
  vim.opt.wildmenu = true

  -- tab settings
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.expandtab = true
  vim.opt.smartcase = true
  vim.opt.smartindent = true
  vim.opt.autowrite = true
  vim.opt.clipboard = "unnamedplus"

  vim.opt.hidden = true
  vim.opt.number = true
  vim.opt.wrap = false

  vim.opt.completeopt = "menuone,noselect"
end

return M
