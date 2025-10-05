return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	lazy = vim.fn.argc(-1) == 0,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	opts = {
		ensure_installed = { "c", "python", "arduino" },
		auto_install = true
	}
}
