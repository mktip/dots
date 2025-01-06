local config = function()
  require("telescope").setup {
    defaults = {},
    pickers = {
      find_files = {
        mappings = {
          n = {
            ["cd"] = function(prompt_bufnr)
              local selection =
                  require("telescope.actions.state").get_selected_entry()
              local dir = vim.fn.fnamemodify(selection.path, ":p:h")
              require("telescope.actions").close(prompt_bufnr)
              -- Depending on what you want put `cd`, `lcd`, `tcd`
              vim.cmd(string.format("lcd %s", dir))
            end
          }
        }
      }
    }
  }
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = true,
  config = config
}
