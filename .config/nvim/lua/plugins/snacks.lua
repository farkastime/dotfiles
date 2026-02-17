return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
  },
  opts = {
    notifier = { enabled = true },
    picker = {
      sources = {
        explorer = {
          enabled = false,
          hidden = true,
          ignored = true,
          -- exclude = { "node_modules" },
        },
      },
    },
  },
}
