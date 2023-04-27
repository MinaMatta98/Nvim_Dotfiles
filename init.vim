" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually
" justinit
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options arezsh
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
" set synmaxcol=12
set encoding=utf-8
set fileencoding=utf-8
set filetype
let skip_defaults_vim=1
set clipboard+=unnamedplus
set cmdheight=0
" Enable autocompletion:
set wildmode=longest,list,full 
set completeopt=menuone,noinsert,noselect
set number relativenumber
syntax on
set incsearch
set hidden
set cursorline
set splitright
set splitbelow
set shiftwidth=4
set softtabstop=4
set tabstop=4
filetype plugin indent on
set smartindent
set suffixesadd=.lua
let mapleader = " "
" au BufRead,BufNewFile *.turtle,*.ttl set filetype=turtle
" set listchars=tab:
" set list
" set listchars=tab:\ \ ┊,trail:●,extends:…,precedes:…
" :set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

map <leader>a :w! \| !setsid bash "/home/mina/autocomp.sh" > /dev/null 2>&1 "<c-r>%"<CR>
map <leader>oo :setlocal spell! spelllang=en_us<CR>
map <leader>v :e $MYVIMRC<CR>
map <leader>m :MaximizerToggle!<CR>
map <c-s-d> :lua vim.diagnostic.open_float({scope="line"})<CR>
nnoremap <silent><c-q> :FloatermNew --cwd=<buffer> --wintype=split --position=right --width=0.5 --height=0.3 <CR>
inoremap <silent><c-q> <Esc> :FloatermToggle<CR>
tnoremap <c-q> <c-\><c-n> :FloatermToggle<CR>
nnoremap <leader>P :lua vim.lsp.buf.format()<CR>
nnoremap <leader>F :LfCurrentDirectoryNewTab<CR>
nnoremap <leader>ff :lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<CR>
nnoremap <silent>  <c-s-l> <Cmd>BufferNext<CR>
nnoremap <silent>  <c-s-h> <Cmd>BufferPrevious<CR>
" nnoremap <leader><space> :Telescope resume<CR>
nnoremap <leader>of :Telescope oldfiles<CR>
nnoremap <leader>s :Telescope live_grep<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>\ :! gcc % -Ofast -o %:t:r -ggdb<CR>
nnoremap <silent> <leader>t :TestNearest<CR>
nnoremap <silent> <leader>T :TestFile<CR>
nnoremap <leader>q :BufferClose<CR>
nnoremap <leader>Q :BufferClose!<CR>
nnoremap <c-d> :lua require('neogen').generate()<CR>
nnoremap <leader>R :so /home/mina/.vim/valgrind.vim<CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
			\ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
			\ fzf#wrap({'dir': expand('%:p:h')}))
if has('nvim')
	au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
	au! FileType fzf tunmap <buffer> <Esc>
endif
" noremap <silent> <C-H> :TmuxNavigateLeft<CR>

call plug#begin()
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'dstein64/vim-startuptime'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'Pocco81/dap-buddy.nvim'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
" Plug 'lvimuser/lsp-inlayhints.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'prichrd/netrw.nvim'
Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'neovim/nvim-lspconfig'
Plug 'Rakr/vim-one'
Plug 'windwp/nvim-autopairs'
Plug 'sbdchd/neoformat'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'startup-nvim/startup.nvim'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'gfanto/fzf-lsp.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter' , {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
" Plug 'dominikduda/vim_current_word'
" Plug 'joshdick/onedark.vim'
Plug 'navarasu/onedark.nvim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'romgrk/barbar.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-lua/popup.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'LunarVim/onedarker.nvim'
Plug 'lunarvim/horizon.nvim'
Plug 'lunarvim/synthwave84.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jay-babu/mason-nvim-dap.nvim'
Plug 'jayp0521/mason-null-ls.nvim'
Plug 'danymat/neogen'
Plug 'SmiteshP/nvim-navic'
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins', 'commit': '0fcd00cdbe167b1a5e3315ff737f6f01fc99d491' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'andymass/vim-matchup'
Plug 'ray-x/lsp_signature.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'neomake/neomake'
Plug 'iurimateus/luasnip-latex-snippets.nvim'
Plug 'tanvirtin/vgit.nvim', { 'commit' : '618471f' }
Plug 'mattn/webapi-vim'
Plug 'sharkdp/fd'
Plug 'BurntSushi/ripgrep'
Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' }
call plug#end()

" let g:onedark_config = {
"     \ 'style': 'dark',
" 	\ 'diagnostics': {
" 	\ 'undercurl': 'false'}
" 	\}
" colorscheme onedarker
" set background=dark

if (has("termguicolors"))
set termguicolors
endif

" let g:markdown_fenced_languages = ['c', 'bash', 'javascript', 'go', 'zsh', 'python', 'diff']
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:neoformat_try_node_exe = 1
let g:fzf_buffers_jump = 1
let g:coq_settings = { 'auto_start': 'shut-up' }
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:lf_replace_netrw = 1
let g:floaterm_position = 'right'
let g:floaterm_wintype = 'vsplit'
let g:floaterm_width = 0.999999999
let g:maximizer_set_default_mapping = '<leader>m'
let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true
let bufferline.closable = v:false
let g:tmux_navigator_no_mappings = 1
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_matchit = 1
" autocmd! BufReadPost,BufNewFile * :setlocal winbar=

" highlight IndentBlanklineContextChar guifg=#fff000 gui=nocombine
noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>

" let g:floaterm_height = 0.85
let g:floaterm_opener = 'vsplit'
" let g:floaterm_autohide = 1
lua require('init')
set encoding=UTF-8
" hi CurrentWord guibg=#31313a
hi BufferTabpageFill guibg='#222436'
" highlight IndentBlanklineContextChar guifg=gray gui=nocombine
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! link CmpItemKindInterface CmpItemKindVariable
highlight! link CmpItemKindText CmpItemKindVariable
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! link CmpItemKindMethod CmpItemKindFunction
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! link CmpItemKindProperty CmpItemKindKeyword
highlight! link CmpItemKindUnit CmpItemKindKeyword

let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
let g:livepreview_previewer = 'alacritty -e zathura'
let g:vimtex_compiler_method = 'latexmk'
let maplocalleader = " "

let g:magma_automatically_open_output = v:false
