return {
	-- 1. ADD THE VIMTEX PLUGIN
	-- This is a new plugin, so we add it normally
	{
		"lervag/vimtex",
		ft = { "tex" }, -- Load it only for .tex files
		init = function()
			-- These are your custom settings for vimtex
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_method = "latexmk"
		end,
		-- These are the keymaps that were missing
		keys = {
			{ "<leader>ll", "<plug>(vimtex-compile)", desc = "Compile" },
			{ "<leader>lv", "<plug>(vimDtex-view)", desc = "View" },
			{ "<leader>ls", "<plug>(vimtex-status)", desc = "Status" },
			{ "<leader>lk", "<plug>(vimtex-compile-stop)", desc = "Stop" },
			{ "<leader>lc", "<plug>(vimtex-clean)", desc = "Clean" },
			{ "<leader>lC", "<plug>(vimtex-clean-full)", desc = "Clean All" },
			{ "<leader>lo", "<plug>(vimtex-toc-open)", desc = "Open TOC" },
		},
	},

	-- 2. MODIFY MASON
	-- This plugin is already loaded by LazyVim, so we just modify its 'opts'
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			-- This line ensures the 'ensure_installed' table exists
			opts.ensure_installed = opts.ensure_installed or {}
			-- Add our LSPs and formatters to the 'ensure_installed' list
			vim.list_extend(opts.ensure_installed, {
				"texlab",
				"chktex",
				"latexindent",
			})
			return opts
		end,
	},

	-- 3. MODIFY LSPCONFIG
	-- This plugin is also loaded by LazyVim
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- Add settings for the texlab server
			servers = {
				texlab = {}, -- This will be merged with other servers
			},
		},
	},

	-- 4. MODIFY CONFORM (FORMATTER)
	{
		"stevearc/conform.nvim",
		opts = {
			-- Add format-on-save for tex files
			formatters_by_ft = {
				tex = { "latexindent" },
			},
		},
	},
}
