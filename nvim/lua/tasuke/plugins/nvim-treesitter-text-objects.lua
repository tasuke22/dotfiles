return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "代入部分の外側を選択" },
            ["i="] = { query = "@assignment.inner", desc = "代入部分の内側を選択" },

            ["a:"] = { query = "@parameter.outer", desc = "パラメーター/フィールド部分の外側を選択" },
            ["i:"] = { query = "@parameter.inner", desc = "パラメーター/フィールド部分の内側を選択" },

            ["ai"] = { query = "@conditional.outer", desc = "条件式部分の外側を選択" },
            ["ii"] = { query = "@conditional.inner", desc = "条件式部分の内側を選択" },

            ["al"] = { query = "@loop.outer", desc = "ループ部分の外側を選択" },
            ["il"] = { query = "@loop.inner", desc = "ループ部分の内側を選択" },

            ["ab"] = { query = "@block.outer", desc = "ブロック部分の外側を選択" }, -- デフォルトのテキストオブジェクト（括弧から括弧まで）を上書き
            ["ib"] = { query = "@block.inner", desc = "ブロック部分の内側を選択" }, -- デフォルトのテキストオブジェクト（括弧から括弧まで）を上書き

            ["af"] = { query = "@function.outer", desc = "関数部分の外側を選択" },
            ["if"] = { query = "@function.inner", desc = "関数部分の内側を選択" },

            ["ac"] = { query = "@class.outer", desc = "クラス部分の外側を選択" },
            ["ic"] = { query = "@class.inner", desc = "クラス部分の内側を選択" },
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>on"] = "@parameter.inner", -- swap object under cursor with next
          },
          swap_previous = {
            ["<leader>op"] = "@parameter.inner", -- swap object under cursor with previous
          },
        },
      },
    })
  end,
}
