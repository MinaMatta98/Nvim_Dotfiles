-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
require("initialization.init")
require("lsp.init")
require("utilities.init")
require("dap-python").setup("~/micromamba/envs/ML/bin/python3")
