return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.enable('pyright')
		vim.lsp.enable('lua_ls')
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
}
