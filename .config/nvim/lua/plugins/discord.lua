--[[return {
  "andweeb/presence.nvim",
  lazy = false, -- load on startup
  opts = {
    editing_text = "Working on %s",
    file_browser_text = "Browsing files",
    workspace_text = function()
    main_image = "file" 
      -- Try to get the current working directory’s name
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      if cwd == "" or cwd == nil then
        cwd = "Unknown Project"
      end
      return "In project: " .. cwd
    end,
  },
}]]
