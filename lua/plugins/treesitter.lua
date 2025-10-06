return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = { "c", "python", "arduino" },
		auto_install = true
	},
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	lazy = vim.fn.argc(-1) == 0,
}
