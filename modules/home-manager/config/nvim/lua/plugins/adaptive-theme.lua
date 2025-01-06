
return {
		"mktip/adaptive-theme.nvim",
    dependencies = {
      { "projekt0n/github-nvim-theme" }
    },
		opts = {
			theme_handler = function(background)
				if background == "none" then
					return
				end

				vim.o.background = background
				if background == "dark" then
					vim.cmd [[colorscheme oxocarbon ]]
				else
					vim.cmd [[colorscheme oxocarbon ]]
				end
			end
		}
	}
