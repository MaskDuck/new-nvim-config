return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufReadPre" },
	config = function()
		vim.lsp.enable('pyright')
		vim.lsp.enable('lua_ls')
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				vim.keymap.set('n', "<CR>", function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = "Hover" })
				vim.diagnostic.config({
					virtual_text = {
						-- source = "always",  -- Or "if_many"
						prefix = '●', -- Could be '■', '▎', 'x'
					},
					severity_sort = true,
					float = {
						source = "always", -- Or "if_many"
					},
					update_in_insert = true,
				})
			end
		})
	end
}
