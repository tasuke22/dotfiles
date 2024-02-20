return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {--[[ things you want to change go here]]
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts),
    })
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
  end,
}
