-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fd",
        function() Snacks.picker.diagnostics() end,
        desc = "Diagnostics",
      },
      {
        "<leader>fD",
        function() Snacks.picker.diagnostics_buffer() end,
        desc = "Buffer Diagnostics",
      },
    },
    opts = {
      dashboard = {
        width = 60,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        pane_gap = 4, -- empty columns between vertical panes
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
        -- These settings are used by some built-in sections
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          -- Used by the `header` section
          header = [[
    ,---,.   ,--,                                    ____               
  ,'  .'  \,--.'|                                  ,'  , `.             
,---.' .' ||  | :            ,--,               ,-+-,.' _ |             
|   |  |: |:  : '          ,'_ /|            ,-+-. ;   , ||  .--.--.    
:   :  :  /|  ' |     .--. |  | :    ,---.  ,--.'|'   |  || /  /    '   
:   |    ; '  | |   ,'_ /| :  . |   /     \|   |  ,', |  |,|  :  /`./   
|   :     \|  | :   |  ' | |  . .  /    /  |   | /  | |--' |  :  ;_     
|   |   . |'  : |__ |  | ' |  | | .    ' / |   : |  | ,     \  \    `.  
'   :  '; ||  | '.'|:  | : ;  ; | '   ;   /|   : |  |/       `----.   \ 
|   |  | ; ;  :    ;'  :  `--'   \'   |  / |   | |`-'       /  /`--'  / 
|   :   /  |  ,   / :  ,      .-./|   :    |   ;/          '--'.     /  
|   | ,'    ---`-'   `--`----'     \   \  /'---'             `--'---'   
`----'                              `----'                              
          ]],
        },
        -- item field formatters
        formats = {
          icon = function(item)
            if item.file and (item.icon == "file" or item.icon == "directory") then
              return require("snacks.dashboard").icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "icon" }
          end,
          footer = { "%s", align = "center" },
          header = { "%s", align = "center" },
          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match "^(.*)/(.+)$"
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
          -- {
          --   pane = 2,
          --   section = "terminal",
          --   cmd = [[bash -c 'echo -e "\e[1;32m ____                      _      _ _ _ \e[0m";
          --         echo -e "\e[1;34m/ ___|  __ _ _ __   __ _  / \    | | | |\e[0m";
          --         echo -e "\e[1;36m\___ \ / _\` |  _ \ / _\` |/ _ \   | | | |\e[0m";
          --         echo -e "\e[1;35m ___) | (_| | | | | (_| / ___ \  |_|_|_|\e[0m";
          --         echo -e "\e[1;31m|____/ \__,_|_| |_|\__, /_/   \_\ (_|_|_)\e[0m";
          --         echo "";
          --         date "+%A, %B %d %Y %H:%M:%S"' ]],
          --   height = 7,
          --   padding = 1,
          -- },
          -- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          -- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
