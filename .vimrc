" ============================================================================
" Vim 基础配置文件
" ============================================================================

" 启用 Vim 的增强功能，不兼容传统 Vi
set nocompatible

" ============================================================================
" 基本设置
" ============================================================================

" 启用语法高亮
syntax on

" 显示行号
set number

" 显示相对行号（方便使用 vim motion）
set relativenumber

" 高亮当前行
set cursorline

" 启用鼠标支持（所有模式）
set mouse=a

" 设置编码
set encoding=utf-8
set fileencoding=utf-8

" 使用系统剪贴板
set clipboard=unnamed

" ============================================================================
" 缩进和制表符设置
" ============================================================================

" 自动缩进
set autoindent
set smartindent

" 使用空格代替 Tab
set expandtab

" Tab 宽度为 4 个空格
set tabstop=4
set shiftwidth=4
set softtabstop=4

" ============================================================================
" 搜索设置
" ============================================================================

" 搜索时忽略大小写
set ignorecase

" 如果搜索包含大写字母，则区分大小写
set smartcase

" 高亮搜索结果
set hlsearch

" 实时搜索（边输入边搜索）
set incsearch

" ============================================================================
" 界面设置
" ============================================================================

" 显示命令
set showcmd

" 显示当前模式
set showmode

" 总是显示状态栏
set laststatus=2

" 显示匹配的括号
set showmatch

" 启用自动换行
set wrap

" 在单词边界换行
set linebreak

" 显示行尾的空白字符
set list
set listchars=tab:→\ ,trail:·,extends:>,precedes:<

" ============================================================================
" 编辑增强
" ============================================================================

" 允许在未保存时切换缓冲区
set hidden

" 自动读取外部修改的文件
set autoread

" 启用命令行补全
set wildmenu
set wildmode=longest:full,full

" 设置回退目录
set backspace=indent,eol,start

" 保存撤销历史
set undofile
set undodir=~/.vim/undodir

" 设置备份和交换文件目录
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" ============================================================================
" 性能优化
" ============================================================================

" 更快的更新时间（毫秒）
set updatetime=300

" 不生成备份文件
" set nobackup
" set nowritebackup

" 不生成交换文件
" set noswapfile

" ============================================================================
" 颜色主题
" ============================================================================

" 设置背景色
set background=dark

" 启用真彩色支持（如果终端支持）
if has('termguicolors')
    set termguicolors
endif

" ============================================================================
" 文件类型设置
" ============================================================================

" 启用文件类型检测
filetype on

" 根据文件类型加载插件
filetype plugin on

" 根据文件类型使用不同的缩进
filetype indent on

" Java 文件特定设置
autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" ============================================================================
" 键位映射
" ============================================================================

" 设置 Leader 键为空格
let mapleader = " "

" 快速保存
nnoremap <leader>w :w<CR>

" 快速退出
nnoremap <leader>q :q<CR>

" 取消搜索高亮
nnoremap <leader>h :nohlsearch<CR>

" 窗口导航
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 移动行（Visual 模式）
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" 保持视觉模式下的缩进
vnoremap < <gv
vnoremap > >gv

" 更好的粘贴（不覆盖寄存器）
xnoremap <leader>p "_dP

" 复制到系统剪贴板
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" 从系统剪贴板粘贴
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" ============================================================================
" 自动命令
" ============================================================================

" 创建必要的目录
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "p")
endif
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p")
endif
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "p")
endif
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p")
endif

" 打开文件时跳转到上次编辑位置
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" 保存时自动删除行尾空格
autocmd BufWritePre * :%s/\s\+$//e

" ============================================================================
" 状态栏设置
" ============================================================================

" 自定义状态栏
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %f\
set statusline+=%#LineNr#
set statusline+=\ %m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\
