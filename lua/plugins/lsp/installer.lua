local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
		ui = {
				icons = {
						server_installed = "✓",
						server_pending = "➜",
						server_uninstalled = "✗"
				}
		}
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("plugins.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "clangd" then
		local clangd_opts = require('plugins.lsp.settings.clangd')
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
