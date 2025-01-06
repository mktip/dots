local M = {}

M.config = function()
  --  augroup FormatAutogroup
  --    autocmd!
  --    autocmd BufWritePost * silent FormatWrite
  --  augroup END

  vim.api.nvim_exec([[
  augroup TrimTrailingWhiteSpace
      au!
      au BufWritePre * %s/\s\+$//e
      au BufWritePre * %s/\n\+\%$//e
  augroup END
]], true)
end

return M
