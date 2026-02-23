-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- php plugins
        "intelephense",
        "phpcs",

        -- formatters
        "prettierd",
        -- "php-cs-fixer",

        -- docker
        "docker-compose-language-service",
        "dockerfile-language-server",

        -- yawascript
        "emmet-ls",
        "eslint_d",
        "typescript-language-server",
        "tailwindcss-language-server",

        -- python
        "black",
        "debugpy",
        "python-lsp-server",

        -- utils / lua
        "bash-language-server",
        "lua-language-server",
        "selene",
        "shfmt",
        "stylua",
        "tree-sitter-cli",

        -- reserved
        "prisma-language-server",
        -- "blade-formatter",
        -- "vtsls",
        -- "laravel-ls",
      },
    },
  },
}
