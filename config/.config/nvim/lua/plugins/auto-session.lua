return {
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
    auto_restore_last_session = true,
  },
  keys = {
    { "<leader>ss", "<cmd>AutoSession save<cr>", desc = "Session Save"},
    { "<leader>sr", "<cmd>AutoSession restore<cr>", desc = "Session Restore"},
    { "<leader>sf", "<cmd>AutoSession search<cr>", desc = "Session Find"},
  }
}
