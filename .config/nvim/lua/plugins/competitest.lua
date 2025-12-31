return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",

	-- This function runs AFTER the plugin is loaded
	config = function()
		require("competitest").setup({
			testcases_directory = "testcase/",

			compile_command = {
				cpp = {
					exec = "g++",
					args = {
						-- Your compiler flags
						"-std=c++17",
						"-O2",
						"-DREZE",
						"-Wall",

						-- The source file
						"$(FNAME)",

						-- The output flag
						"-o",

						-- The new executable name
						"$(FNOEXT).out",
					},
				},
			},

			-- 2. Override the C++ run command to match
			run_command = {
				cpp = { exec = "./$(FNOEXT).out" },
			},
		})
	end,

	-- This table creates keymaps for the plugin
	keys = {
		-- Keymap for Running tests
		{
			"<leader>r", -- Press <leader> then r twice
			":CompetiTest run<CR>",
			desc = "Run CompetiTest",
		},

		-- Keymap for Adding a test case
		{
			"<leader>ra", -- Press <leader> then r then a
			":CompetiTest add_testcase<CR>",
			desc = "Add CompetiTest Testcase",
		},

		-- Keymap for Editing a test case
		{
			"<leader>re", -- Press <leader> then r then e
			":CompetiTest edit_testcase<CR>",
			desc = "Edit CompetiTest Testcase",
		},

		-- Keymap for Receiving test cases (from browser)
		{
			"<leader>ro", -- Press <leader> then r then o
			":CompetiTest receive<CR>",
			desc = "Receive CompetiTest Testcases",
		},
	},
}
