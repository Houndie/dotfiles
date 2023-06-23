require('packer').startup(function(use)
	-- manage itself
	use 'wbthomason/packer.nvim'

	-- manage language servers
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'

	use 'neovim/nvim-lspconfig'
	use 'simrat39/rust-tools.nvim'

	-- Completion framework:
	use 'hrsh7th/nvim-cmp'

	-- LSP completion source:
	use 'hrsh7th/cmp-nvim-lsp'

	-- Useful completion sources:
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/vim-vsnip'

	use 'nvim-treesitter/nvim-treesitter'

	use 'puremourning/vimspector'

	use 'folke/tokyonight.nvim'

	use 'nvim-lua/plenary.nvim'
	use 'BurntSushi/ripgrep'
	use 'nvim-telescope/telescope.nvim'

	use {
		'nvim-neotest/neotest',
		requires = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
		}
	}

	use 'nvim-orgmode/orgmode'
end)

require("mason").setup()
require("mason-lspconfig").setup {
	-- rust_analyzer is automatically set up by rust-tools plugin
	ensure_installed = { "gopls", "lua_ls", "tsserver" },
}

local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})

-- Golang lsp
local lspconfig = require("lspconfig")
lspconfig.gopls.setup {}
lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
lspconfig.tsserver.setup {
	root_dir = lspconfig.util.root_pattern("package.json", ".git")
}

-- Lsp buttons
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	end,
})

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Completion Plugin Setup
local cmp = require 'cmp'
cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- Add tab support
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},
	-- Installed sources:
	sources = {
		{ name = 'path' },                         -- file paths
		{ name = 'nvim_lsp',               keyword_length = 3 }, -- from language server
		{ name = 'nvim_lsp_signature_help' },      -- display function signatures with current parameter emphasized
		{ name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = 'buffer',                 keyword_length = 2 }, -- source current buffer
		{ name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		{ name = 'calc' },                         -- source for math calculation
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { 'menu', 'abbr', 'kind' },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = 'λ',
				vsnip = '⋗',
				buffer = 'Ω',
				path = '🖫',
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})

local orgmode = require('orgmode')
orgmode.setup_ts_grammar()

-- Treesitter Plugin Setup
require('nvim-treesitter.configs').setup {
	ensure_installed = { "lua", "rust", "toml", "go", "org" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { 'org' },
		disable = { "starlark" },
	},
	ident = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	}
}

local nextcloud_path = os.getenv("NEXTCLOUD")
orgmode.setup {
	org_agenda_files = { nextcloud_path .. '/org/*' },
	org_default_notes_file = nextcloud_path .. '/org/refile.org',
}

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldenable = false

-- Vimspector options
vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Vimspector
vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
map('n', "Dw", ":call vimspector#AddWatch()<cr>")
map('n', "De", ":call vimspector#Evaluate()<cr>")

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.cmd [[colorscheme tokyonight-night]]

-- Telescope (file finder)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})

-- Neotest
local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-go")
	},
	output = {
		open_on_run = true,
	},
})
vim.keymap.set("n", "<leader>tt", function() neotest.run.run() end)
vim.keymap.set("n", "<leader>tT", function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true }) end)
vim.keymap.set("n", "<leader>ts", function() neotest.summary.open() end)
