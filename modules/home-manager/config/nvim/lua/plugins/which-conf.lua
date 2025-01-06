function rename_file()
  local old_name = vim.fn.expand("%:p")
  local new_name = vim.fn.input("New name: ", old_name, "file")
  if new_name ~= "" then
    vim.fn.rename(old_name, new_name)
    vim.cmd("edit " .. new_name)
  end
end

function create_note()
  local new_name = vim.fn.input("New note title: ")
  require("zk").new({ title = new_name })
end

_G.laststatus = 0

-- toggle statusline
function toggle_status()
  if _G.laststatus == 0 then
    _G.laststatus = 2
  else
    _G.laststatus = 0
  end
  vim.opt.laststatus = _G.laststatus
end

local config = function()
  local wk = require("which-key")

  wk.setup({ plugins = { spelling = { enabled = true } } })

  wk.add(
    {
      { "<space><leader>", "\30",                                                                                         desc = "Alternate Buffer" },
      { "<space>b",        group = "buff" },
      { "<space>bb",       "<cmd>lua require('telescope.builtin').buffers()<CR>",                                         desc = "Find Buffer" },
      { "<space>bg",       "<cmd>lua require('telescope.builtin').live_grep()<CR>",                                       desc = "Grep In Buffer" },
      { "<space>e",        group = "edit" },
      { "<space>ec",       "<cmd>lua require('telescope.builtin').find_files({search_dirs = {\"~/.config/\"}})<CR>",      desc = "Edit Config" },
      { "<space>ei",       "<cmd>lua require('telescope.builtin').find_files({search_dirs = {\"~/docs/tils/\"}})<cr>",    desc = "edit til" },
      { "<space>em",       "<cmd>ZkNotes<CR>",                                                                            desc = "Open mind map" },
      { "<space>en",       create_note,                                                                                   desc = "Create a new note" },
      { "<space>er",       "<cmd>lua require('telescope.builtin').find_files({search_dirs = {\"~/.config/nvim/\"}})<CR>", desc = "Edit Nvim" },
      { "<space>et",       "<cmd>lua require('telescope.builtin').find_files({search_dirs = {\"~/docs/todo/\"}})<CR>",    desc = "Edit Todos" },
      { "<space>f",        group = "file" },
      { "<space>ft",       "<cmd>NvimTreeToggle<cr>",                                                                     desc = "Open File Tree" },
      { "<space>fc",       "<cmd>lua require('telescope.builtin').oldfiles()<cr>",                                        desc = "Open Recent File" },
      { "<space>ff",       "<cmd>lua require('telescope.builtin').find_files({ previewer = false })<cr>",                 desc = "Find File" },
      { "<space>fn",       "<cmd>enew<cr>",                                                                               desc = "New File" },
      { "<space>m",        group = "Molten" },
      { "<space>mi",       "<cmd>MoltenInit<CR>",                                                                         desc = "Initialise Molten" },
      { "<space>me",       "<cmd>MoltenEvaluateOperator<CR>",                                                             desc = "Evaluate Operator" },
      { "<space>ml",       "<cmd>MoltenEvaluateLine<CR>",                                                                 desc = "Evaluate Line" },
      { "<space>mc",       "<cmd>MoltenEvaluateCell<CR>",                                                                 desc = "Evaluate Cell" },
      { "<space>mv",       "<cmd><C-u>MoltenEvaluateVisual<CR>gv",                                                        desc = "Evaluate Visual" },
      { "<space>fr",       rename_file,                                                                                   desc = "Rename File" },
      { "<space>g",        group = "lsp" },
      { "<space>ga",       "<cmd>lua vim.lsp.buf.code_action()<CR>",                                                      desc = "Code Action" },
      { "<space>gd",       "<cmd>lua vim.lsp.buf.definition()<CR>",                                                       desc = "Jump To Definition" },
      { "<space>gi",       "<cmd>lua vim.lsp.buf.implementation()<CR>",                                                   desc = "Jump To Implementation" },
      { "<space>gs",       "<cmd>lua vim.lsp.buf.references()<CR>",                                                       desc = "Show References" },
      { "<space>gt",       "<cmd>lua vim.lsp.buf.typehierarchy()<CR>",                                                    desc = "Show Typehierarchy" },
      { "<space>gh",       "<cmd>lua vim.lsp.buf.hover()<CR>",                                                            desc = "Hover" },
      { "<space>gl",       "<cmd>lua vim.lsp.buf.format { async = true }<CR>",                                            desc = "Format" },
      { "<space>gr",       "<cmd>lua vim.lsp.buf.rename()<CR>",                                                           desc = "Rename" },
      { "<space>u",        group = "util" },
      { "<space>un",       "<cmd>nohlsearch<CR>",                                                                         desc = "Unhighlight Search" },
      { "<space>uz",       toggle_status,                                                                                 desc = "Toggle Status Bar" },
    }
  )
end

-- declaration              document_highlight       execute_command          hover                    incoming_calls           outgoing_calls           remove_workspace_folder  signature_help           typehierarchy
-- definition               document_symbol          format                   implementation           list_workspace_folders   references               rename                   type_definition          workspace_symbol

return {
  "folke/which-key.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  config = config,
}
