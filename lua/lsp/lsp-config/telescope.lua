local builtin = require("telescope.builtin")
vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions
vim.lsp.handlers["textDocument/declaration"] = builtin.lsp_declarations
vim.lsp.handlers["textDocument/typeDefinition"] = builtin.lsp_type_definitions
vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
vim.lsp.handlers["textDocument/documentSymbol"] = builtin.lsp_document_symbols
vim.lsp.handlers["workspace/symbol"] = builtin.lsp_workspace_symbols
vim.lsp.handlers["callHierarchy/incomingCalls"] = builtin.lsp_incoming_calls
vim.lsp.handlers["callHierarchy/outgoingCalls"] = builtin.lsp_outgoing_calls
