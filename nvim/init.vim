" Plugins
let plug_script_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_script_path))
  execute 'silent !curl -fLo ' . plug_script_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
  Plug 'jvirtanen/vim-hcl'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'morhetz/gruvbox'
  Plug 'voldikss/vim-floaterm'
  Plug 'ptzz/lf.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vimwiki/vimwiki'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'dag/vim-fish'
  Plug 'luochen1990/rainbow'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Settings
let mapleader = ' '

let g:gruvbox_contrast_dark = 'hard'
let g:lf_replace_netrw = 1
let g:vimwiki_list = []
let g:vimwiki_list = g:vimwiki_list + [{'path': '~/Documents/Notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:rainbow_active = 1

set clipboard+=unnamedplus
set cmdheight=2 " Give more space for displaying messages.
set completeopt=menuone,noselect
set expandtab
set foldmethod=marker
set hidden " TextEdit might fail if hidden is not set.
set list
set listchars=eol:$,tab:-⇥,trail:~,extends:>,precedes:<
set mouse=a
set nobackup " Some servers have issues with backup files, see #649.
set nowritebackup
set number
set relativenumber
set shiftwidth=2
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set softtabstop=2
set tabstop=2
set updatetime=300
set wildignore+=*\\target\\*,*\\.svn\\*,*\\.git\\*,*\\workspace\\*,*\\build\\*

" Key mappings
imap jj <Esc>
inoremap <S-Tab> <C-D>
nmap <Leader>F :split<CR>:Lf<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Lf<CR>
nmap <Leader>g :GFiles -co --exclude-standard<CR>
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>ts <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>tS <cmd>Telescope lsp_dynamic_workspace_symbols<cr>

nnoremap <S-Tab> <<_
nnoremap <Tab> >>_
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

colorscheme gruvbox

lua require('myluaconfig')

echo 'End of init.vim'

let localrc = getcwd() . '/.vimrc'
if filereadable(localrc)
  echo 'Loading ' . localrc
  execute 'source ' . localrc
endif

