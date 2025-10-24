return {
  "folke/snacks.nvim",
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
