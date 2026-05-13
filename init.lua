-- Set keymap
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main", 
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.config")
        configs.setup({
          -- A few parsers are now built-in; ensure these are handled
          ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },
  },
  install = { missing = true, colorscheme = { "habamax" } },
})
