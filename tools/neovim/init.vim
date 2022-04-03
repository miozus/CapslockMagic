" =================================================== 
" 
"      ███╗   ██╗██╗   ██╗██╗███╗   ███╗
"      ████╗  ██║██║   ██║██║████╗ ████║
"      ██╔██╗ ██║██║   ██║██║██╔████╔██║
"      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
"      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
"      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"                               
"
"   作者：@miozus 2021/4/15 17:21 
"   起源：设置 Meta 键, 受 KaraBiner Hyper CapsLock 启发
"   发现Vim 设计哲学,对篇/页/段/行/词/字/符的精准控制，入坑
"   
"   * B站CW curd 操作,某 wang 通用设置
"   * 插件 fzf / tree 和主题色 ondark
"   * Neovim 官方文档，常用插件
"   * Tmux 外围系统配色问题,学习 Vim Awesome 高分插件
"   * 融合开发工具编辑器 idea 和 vscode 局部调整
"   
"   更新：2021/11/09 随机参考 Github 配置
"        * 重新梳理此文件（针对 vscode 区别对待）
"        * operator Pending 简化i？一个键
"        * HL ⇒ ^$ 神来之笔
"
" =================================================== 

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:mapleader = " "

""" 通用设置 ----------------------------------------- 
set number
set relativenumber
set showced
set hlsearch
set incsearch
set scrolloff=5
set smartcase ignorecase
set clipboard=unnamed
" 多平台通用 / VIM 独占   
set wildmenu " 补全命令
set wrap " 自动换行
set history=10000
set shell=/bin/zsh
exec "nohlsearch"

" 如果没有插件包，自动下载插件管理工具
" if !exists('g:vscode')
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"         autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"         endif
" endif

" vscode neovim forced me to do this
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
Plug 'vim-airline/vim-airline', Cond(!exists('g:vscode'))
Plug 'vim-airline/vim-airline-themes', Cond(!exists('g:vscode'))
Plug 'mg979/vim-visual-multi', Cond(!exists('g:vscode'), {'branch': 'master'})
Plug 'preservim/nerdtree', Cond(!exists('g:vscode'))
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'christoomey/vim-tmux-navigator'  
Plug 'github/copilot.vim'
"Plug 'chrisbra/csv.vim' " 神马鬼东西
"Plug 'neoclide/coc.nvim', {'branch': 'release'} "自动补全
"Plug 'lyokha/vim-xkbswitch' " X keyboard switch for Mac
call plug#end()


""" 键位映射--------------------------  

map Q :q<CR>
inoremap <C-b> <C-o>de
noremap <Leader><CR> :nohlsearch<CR>
noremap n nzz
noremap N Nzz
" Window Movements
nnoremap <Leader>w- <C-W>s
nnoremap <Leader>w\| <C-W>v 
nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wx <C-W>c
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l

""" 宏 Macro 可惜ide不兼容 --------------------------  
"noremap tp yy<C-O>p

" Operator Pending 少按一次的快捷键 c/d/y = o
" Docs: https://medium.com/usevim/operator-pending-mode-a4247d8596b7
" Docs: https://dev.to/iggredible/basic-vim-mapping-5ahj

onoremap " i"
onoremap ] i]
onoremap [ i[
onoremap b ib
onoremap B iB
onoremap w iw
onoremap W iW

" vno
vnoremap ] i]
vnoremap [ i[
vnoremap b ib
vnoremap B iB
vnoremap w iw
vnoremap W iW

" 因为需要复制整段，这样写就不能}跨段落了，这里使用b/B代替;不要写 ' ⇒ i' 因为会丢失书签
"onoremap } i}

nnoremap < <<
nnoremap > >>

nnoremap dP ddkP
nnoremap dp ddp
nnoremap dc d'c
nnoremap yc y'c
nnoremap yp yyp
nnoremap yP yyP

nnoremap Y y$
nnoremap H gT
nnoremap L gt

nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN


vnoremap <Leader>p "_dP

" fzf.vim
nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>
let g:fzf_action = { 'ctrl-e': 'edit' }

if !exists('g:vscode')
  map R :source $MYVIMRC<CR>
  nnoremap <Leader>s :w<CR>
endif

if exists('g:vscode')
  " F2
  nnoremap <C-p> <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
  nnoremap <Leader>n <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
  nnoremap <Leader>j <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
  nnoremap <Leader>o <Cmd>call VSCodeNotify('outline.focus')<CR>
  nnoremap <Leader>z <Cmd>call VSCodeNotify('workbench.action.toggleZenMode')<CR>
  nnoremap <Leader>f <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
  nnoremap <Leader>e <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <Leader>a <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
  nnoremap <Leader>s <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <Leader>h <Cmd>call VSCodeNotify('gitlens.showQuickFileHistory')<CR>
  
  """ oritend object
  "" not find in file... + jump
  nnoremap <Leader>gr <Cmd>call VSCodeNotify('references-view.findReferences')<CR>
  " gd
  nnoremap <Leader>gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  " gf
  nnoremap <Leader>gs <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nnoremap <Leader>gz <Cmd>call VSCodeNotify('git.revertSelectedRanges')<CR>

  """ refactor 
  nnoremap <Leader>rr <Cmd>call VSCodeNotify('editor.action.rename')<CR>

  nnoremap <Leader>b <Cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')<CR>
  nnoremap <Leader>dd <Cmd>call VSCodeNotify('workbench.action.debug.start')<CR>

  """ tag
  nmap H gT
  nmap L gt
  
  """ windows manager
  nmap <Leader>w- <C-W>s
  nmap <Leader>w\| <C-W>v 
  nmap <Leader>ww <C-W>w
  nmap <Leader>wx <C-W>c
  nmap <Leader>wh <C-W>h
  nmap <Leader>wj <C-W>j
  nmap <Leader>wk <C-W>k
  nmap <Leader>wl <C-W>l
endif

""" 插件环境配置 --------------------------------------- 
if !exists('g:vscode')
  " NVIM python provide
  let g:python3_host_prog = '/usr/local/opt/python@3.7/bin/python3'
  let g:python_host_prog  = '/usr/bin/python2'
  " fzf
  set rtp+=/usr/local/opt/fzf
  " NERD Tree
  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  " Use K to show documentation in preview window
   function! s:show_documentation()
     if (index(['vim','help'], &filetype) >= 0)
         execute 'h '.expand('<cword>')
           else
               call CocAction('doHover')
                 endif
                 endfunction
                 nnoremap <silent> K :call <SID>show_documentation()<CR>
  " X keyboard switch INSERT 中文 | NORMAL 英文
  let g:XkbSwitchEnabled = 1
  " THEME: onedark
  syntax on
  colorscheme onedark
  highlight Normal ctermbg=None

  """ air-line settings --------------------
  let g:airline_theme='powerlineish'
  if !exists('g:airline_symbols')
        let g:airline_symbols = {}
  endif
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline#extensions#tabline#right_sep = ''
  let g:airline#extensions#tabline#right_alt_sep = ''
  let g:airline#extensions#tabline#formatter = 'default'
  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = '☰'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'
endif

""" keep .vimrc clean settings --------------------
set tabstop=2
set shiftwidth=2
set noexpandtab
