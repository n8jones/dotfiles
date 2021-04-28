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
call plug#end()

" Settings
let mapleader = ' '

let g:gruvbox_contrast_dark = 'hard'
let g:lf_replace_netrw = 1
let g:vimwiki_list = []
let g:vimwiki_list = g:vimwiki_list + [{'path': '~/Documents/Notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:rainbow_active = 1

set clipboard+=unnamedplus
set expandtab
set list
set listchars=eol:$,tab:-⇥,trail:~,extends:>,precedes:<
set mouse=a
set number
set relativenumber
set softtabstop=2
set shiftwidth=2
set tabstop=2
set foldmethod=marker
set wildignore+=*\\target\\*,*\\.svn\\*,*\\.git\\*,*\\workspace\\*,*\\build\\*
set hidden " TextEdit might fail if hidden is not set.
set nobackup " Some servers have issues with backup files, see #649.
set nowritebackup
set cmdheight=2 " Give more space for displaying messages.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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
nnoremap <S-Tab> <<_
nnoremap <Tab> >>_
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

colorscheme gruvbox

echo 'End of init.vim'

let localrc = getcwd() . '/.vimrc'
if filereadable(localrc)
  echo 'Loading ' . localrc
  execute 'source ' . localrc
endif

