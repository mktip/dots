local M = {}

M.config = function()
  local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  map("t", "<Esc>", [[<C-\><C-n>]], {noremap = true})
end

return M
