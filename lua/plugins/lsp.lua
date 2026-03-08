return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufReadPre" },
	config = function()
		vim.lsp.enable('pyright')
		vim.lsp.enable('lua_ls')
		vim.lsp.enable('cssls')
		vim.lsp.enable('jsonls')
		vim.lsp.enable('clangd')
		vim.lsp.config['qmlls'] = {
			cmd = { 'qmlls6' },
			filetypes = { 'qml', 'qmljs' },
			root_markers = { '.git' },
		}
		vim.lsp.enable('qmlls')
		-- vim.lsp.enable('')
		--
		--
		vim.api.nvim_create_user_command('Rn', function()
			vim.lsp.buf.rename()
		end, { desc = '' })


		vim.api.nvim_create_user_command('Goto', function()
			vim.lsp.buf.definition()
		end, { desc = '' })

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
				})
			end
		})
	end
}
