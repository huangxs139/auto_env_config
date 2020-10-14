set nocompatible
"保存全局变量
set viminfo+=!
"设置文件格式为unix，这样换行不会带 ^M
set fileformat=unix

" Force to use Python3 first
if has('python3')
endif

"############################################### begin vim-plug ################################
call plug#begin()
"CurtineIncSw.vim 插件，用于头文件源文件来回切换
Plug 'ericcurtin/CurtineIncSw.vim'
"Molokai 主题
Plug 'tomasr/molokai'
"solarized 主题
"Plug '~/vim-plugin/altercation/vim-colors-solarized'
"类/方法/变量相关侧边栏，依赖 ctags
Plug 'majutsushi/tagbar'
"自动补全括号插件
Plug 'jiangmiao/auto-pairs'
"状态栏
Plug 'vim-airline/vim-airline'
"开箱即用型的语法高亮包，支持大部分前端后台语言
Plug 'sheerun/vim-polyglot'
"缩进线，方便 python 语言对齐
Plug 'Yggdroot/indentLine'
"树形目录插件，延迟加载
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
"配对标签跳转
Plug 'andymass/vim-matchup'
"python PEP8标准自动缩进，在函数多行定义下有用
Plug 'Vimjas/vim-python-pep8-indent'
"python 折叠
Plug 'tmhedberg/SimpylFold'
" vim 中文版文档
Plug 'yianwillis/vimcdoc'
"nerdtree 辅助插件，展示文件状态
Plug 'Xuyuanp/nerdtree-git-plugin'
"版本控制系统 vcs 展示每列的增删改状态，支持大部分 vcs
Plug 'mhinz/vim-signify'
" ycm 辅助
Plug 'tenfyzhong/CompleteParameter.vim'
" ycm 辅助，用于 python 补全
Plug 'davidhalter/jedi-vim'
" 语法检查
Plug 'w0rp/ale'
" 自动生成 tags
Plug 'ludovicchabant/vim-gutentags'
"vim-go
Plug 'fatih/vim-go'
"vim-go 辅助插件，Struct split and join
Plug 'AndrewRadev/splitjoin.vim'
"vim-go 辅助插件，用于片段补全
Plug 'SirVer/ultisnips'
"vim-go 辅助插件，用于搜索函数和类型
"Plug 'ctrlpvim/ctrlp.vim'
" coc-nvim lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"谷歌翻译插件
Plug 'voldikss/vim-translator'
"git blame 用于查看指定行的代码是谁编写的
Plug 'zivyangll/git-blame.vim'
"plantuml 插件
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'
"markdown 插件
Plug 'iamcco/markdown-preview.vim'
"fzf文件查找, 帮助安装最新的二进制文件
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
"vim git
Plug 'tpope/vim-fugitive'
call plug#end()
"############################################### end vim-plug ##################################





"############################################### begin common-conf #############################

"=========================================
" 键盘配置
"=========================================
"设置快捷键的前缀
let mapleader = "\<Space>"
"可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
"mac下支持 yy 等将内容复制到操作系统粘贴版
set clipboard=unnamed
" CTRL + S 保存当前文件
nnoremap <C-S> :w<CR>
" CTRL + Q 退出当前文件且不保存
nnoremap <C-Q> :q!<CR>
" CTRL + LEFT 打开 buffer 文件列表下个文件
nnoremap <C-LEFT> :bn<CR>
" CTRL + RIGHT 打开 buffer 文件列表上个文件
nnoremap <C-RIGHT> :bp<CR>
" CTRL + N 打开下一个 tab
nnoremap <C-N> :tabn<CR>
" CTRL + P 打开上一个 tab
nnoremap <C-P> :tabp<CR>
"tags 跳转，ctrl+左键跳转，且当前行移动到屏幕的顶部
nnoremap <C-LeftMouse> <C-]>zt<CR>
"可视模式 Ctrl + C 选择复制到系统剪贴板
vnoremap <silent> <C-c> "+y<CR>:wviminfo! ~/.viminfo<CR>
"可视模式 CTRL + X 剪切到系统剪贴板
vnoremap <silent> <C-X> "+x<CR>:wviminfo! ~/.viminfo<CR>
"插入模式 CTRL + V 粘贴到系统剪贴板
inoremap <silent> <C-V> :rviminfo! ~/.viminfo<CR>"+p<CR>
"命令模式 CTRL + V 粘贴到系统剪贴板
cnoremap <C-V> <C-R>+<CR>
"Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
"可视模式 CTRL-d vim 和 shell 来回切换
nnoremap <C-d> :shell<CR>
"leader z 最大化或恢复当前窗口
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr() > 1 && tabpagewinnr(tabpagenr(), '') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction
nnoremap <leader>z :call Zoom()<CR>
"=========================================
" 语言配置
"=========================================
"编码
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
" python tab 长度为 2
autocmd Filetype python setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" 开启文件类型检查，这将触发FileType事件，该事件可用于设置语法突出显示，设置选项等
filetype on
" 开启文件类型插件，会在'runtimepath'中加载文件“ftplugin.vim”
filetype plugin on
" 开启文件类型缩进，会在'runtimepath'中加载文件“indent.vim”
filetype indent on
"将输入的TAB自动展开成空格。开启后要输入TAB，需要Ctrl-V<TAB>
set expandtab
"使用每层缩进的空格数
set shiftwidth=2
"编辑时一个TAB字符占多少个空格的位置
set tabstop=2
"方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格
set softtabstop=2
" 使回格键（backspace）正常处理indent(缩进位置), eol(行结束符), start(段首), 很奇怪 Vim 默认竟然不允许在这些地方使用 backspace
set backspace=indent,eol,start
"开启时，在行首按TAB将加入 shiftwidth 个空格，否则加入 tabstop 个空格
set smarttab
"设置光标超过 130 列的时候折行
"set tw=130
"不在单词中间断行，如果一行文字非常长，无法在一行内显示完的话，它会在单词与单词间的空白处断开
"尽量不会把一个单词分成两截放在两个不同的行里
set lbr
"打开断行模块对亚洲语言支持
"m 表示允许在两个汉字之间断行，即使汉字之间没有出现空格
"B 表示将两行合并为一行的时候，汉字与汉字之间不要补空格
set fo+=mB
"显示括号配对情况。打开这个选项后，当输入后括号(包括小括号、中括号、大括号) 的时候，光标会跳回前括号片刻，然后跳回来，以此显示括号的配对情况
"带有如下符号的单词不要被换行分割
set iskeyword+=$,@,%,#,-,_
set sm
"缩进方式，每一行都和前一行有相同的缩进量，当遇到右花括号（}）等，则取消缩进形式
"set smartindent
"缩进方式，用C语言的缩进格式来处理程序的缩进结构
set cindent
"设置当文件被改动时自动载入
set autoread
"当你编辑下一个文件的时候，目前正在编辑的文件如果改动，将会自动保存
set autowrite
"tags 配置
set tags=tags;
"输出时只有文件名，不带./ ../等目录前缀(默认了执行％在当前的目录下)
set autochdir 
"禁止生成临时文件
set noundofile
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
augroup file_type
    autocmd!
    "为特定后缀的文件设置文件类型
    autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
    autocmd BufRead,BufNewFile *.{go}   set filetype=go
    autocmd BufRead,BufNewFile *.{js}   set filetype=javascript
    autocmd BufRead,BufNewFile *.{htm}   set filetype=html
augroup END
"=========================================
" 显示配置
"=========================================
if has("gui_running")
    au GUIEnter * simalt ~x " 窗口启动时自动最大化
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    "set showtabline=0 " 隐藏Tab栏
endif
"打开 vim 语法高亮
syntax on
"在命令模式下使用 Tab 自动补全的时候，将补全内容使用一个漂亮的单行菜单形式显示出来
set wildmenu
"指定在选择文本时，光标所在位置也属于被选中的范围。如果指定 selection=exclusive 的话，可能会出现某些文本无法被选中的情况
set selection=inclusive
"选择字符，使用鼠标时或 shift+特殊键时进入选择模式
set selectmode=mouse,key
"当右键单击窗口的时候，弹出快捷菜单, GUI
set mousemodel=popup
"256位色
set t_Co=256
"高亮光标所在行
set cul
"高亮光标所在列
set cuc
"显示行号
set nu
"显式相对行号
"set rnu
"开启左下角光标位置显示
set ruler
"历史记录数
set history=10000
"在屏幕右下角显示未完成的指令输入，有时候我们输入的命令不是立即生效的，它会稍作等待，等候你是否输入某种组合指令 
set showcmd
"光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
"光标移动的距离
set scroll=1
"高亮显示匹配的括号
set showmatch
"匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
"显示状态栏
set laststatus=2
"突出显示当前行
set cursorline
"设置魔术
set magic
"打开搜索高亮模式，若搜索找到匹配项就高亮显示所有匹配项
set hlsearch
"打开增量搜索模式，Vim 会即时匹配你当前输入的内容，这样会给你更好的搜索反馈
set incsearch
"快捷键可在查询完成后关闭高亮
nnoremap <leader>/ :nohl<CR>
"语言设置
set langmenu=zh_CN.UTF-8
"如果有，就使用vim 中文帮助文档
set helplang=cn
"设置命令行的高度
set cmdheight=1
"menu:匹配多于一个使用弹框显示补全，longest:不懂
set completeopt=longest,menu
"在处理未保存或只读文件的时候，弹出确认
set confirm
"使用 :commands 命令模式时总是报告修改的行数
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
augroup vimrcEx
    "当打开一个文件，跳到上次光标所在位置
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
    " quickfix 模式
    autocmd FileType c,cpp noremap <buffer> <leader><space> :w<cr>:make<cr>
augroup END

"=========================================
" vim omnicompletion 配置
"=========================================
"OmniCppComplete 是根据 Ctags 生成的索引文件进行补全
"开启各种语言的补全
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType python set omnifunc=python3complete#Complete
autocmd FileType JavaScript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"############################################### end common-conf ###############################






"############################################### begin 所有插件配置 #############################
"=========================================
" CurtineIncSw.vim 插件配置
"=========================================
"CTRL + R 头文件源文件来回切换
noremap <C-R> :call CurtineIncSw()<CR>

"=========================================
" CurtineIncSw.vim 插件配置
"=========================================
" CTRL-R头文件源文件来回切换
noremap <C-R> :call CurtineIncSw()<CR>

"=========================================
" molokai 插件配置
"=========================================
"设置背景主题
let g:rehash256=1
let g:molokai_original = 1
color molokai

"=========================================
" vim-colors-solarized 插件配置
"=========================================
"syntax enable
"set background=dark
"colorscheme solarized

"=========================================
" tagbar 插件配置，依赖 ctags
"=========================================
" F9 展示类/方法/变量相关侧边栏
nnoremap <F9> :TagbarToggle<CR>
"启动时自动focus
let g:tagbar_autofocus = 1

"=========================================
" auto-pairs 插件配置
"=========================================

"=========================================
" vim-airline 插件配置
"=========================================
"当只打开一个选项卡时自动显示所有缓冲区
let g:airline#extensions#tabline#enabled = 1

"=========================================
" vim-polyglot 插件配置
"=========================================

"=========================================
" indentLine 插件配置
"=========================================
"打开缩进线
let g:indentLine_enabled = 1

"=========================================
" NERDTree 插件配置
"=========================================
"打开树形目录
noremap <F3> :NERDTreeToggle<CR>
inoremap <F3> <ESC> :NERDTreeToggle<CR>
noremap <F4> :NERDTreeFind<CR>
inoremap <F4> <ESC> :NERDTreeFind<CR>
augroup vimrcEx-NERDTree
    "只剩 NERDTree 时自动关闭
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

"=========================================
" vim-matchup 插件配置
"=========================================

"=========================================
" SimpylFold 插件配置
"=========================================
"在折叠文本中预览 python docstring
let g:SimpylFold_docstring_preview = 1

"=========================================
" nerdtree-git-plugin 插件配置
"=========================================
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"=========================================
" vim-signify 插件配置
"=========================================
" 设置要检查的VCS
let g:signify_vcs_list = ['git', 'svn']
" 插入模式下指定updatetime时间后无操作将缓存区交换文件写入磁盘
let g:signify_cursorhold_insert     = 1
" 正常模式下指定updatetime时间后无操作将缓存区交换文件写入磁盘
let g:signify_cursorhold_normal     = 1
" 缓冲区被修改时更新符号
let g:signify_update_on_bufenter    = 0
" vim获取焦点时更新符号
let g:signify_update_on_focusgained = 1
"仅为当前缓冲区打开插件
nnoremap <leader>gt :SignifyToggle<CR>
" 键盘映射
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gr :SignifyRefresh<CR>
nnoremap <leader>gd :SignifyDebug<CR>
" hunk jumping
nnoremap <leader>gj <plug>(signify-next-hunk)
nnoremap <leader>gk <plug>(signify-prev-hunk)
" hunk text object
onoremap ic <plug>(signify-motion-inner-pending)
xnoremap ic <plug>(signify-motion-inner-visual)
onoremap ac <plug>(signify-motion-outer-pending)
xnoremap ac <plug>(signify-motion-outer-visual)

"=========================================
" vim-python-pep8-indent 插件配置
"=========================================
let g:python_pep8_indent_hang_closing = 1
let g:python_pep8_indent_multiline_string = -2

"=========================================
" CompleteParameter 插件配置
"=========================================
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

"=========================================
" jedi-vim 插件配置
"=========================================
let g:jedi#force_py_version=3
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"


"=========================================
" ale 插件配置
"=========================================
"keep the sign gutter open
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" show errors or warnings in my statusline
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
""<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
" only the linters from g:ale_linters and b:ale_linters will be enable
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \   'cpp': ['cppcheck'],
            \   'c': ['cppcheck'],
            \   'python': ['pylint'],
            \}
" normal 模式下文字改变运行 linter
let g:ale_lint_on_text_changed = 'normal'
" 离开 insert 模式的时候运行 linter
let g:ale_lint_on_insert_leave = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++0x'
let g:ale_c_cppcheck_options = '--enable=all'
let g:ale_cpp_cppcheck_options = '--enable=all'

"=========================================
" vim-gutentags 插件配置
"=========================================
"gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
"配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"=========================================
" vim-go 插件配置
"=========================================
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
map <leader>] :cnext<CR>
map <leader>[ :cprevious<CR>
nnoremap <leader>[[ :cclose<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"保存文件时自动 import package
let g:go_fmt_command = "goimports"
"高亮类型
"let g:go_highlight_types = 1
"高亮函数
"let g:go_highlight_functions = 1
"高亮操作符
let g:go_highlight_operators = 1
"保存时自动执行 'vet', 'golint', 'errcheck'
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "10s"
"自动展示光标下的类型信息
let g:go_auto_type_info = 1
"禁用自动跳转到第一个错误的代码，因为保存时检查错误就自动跳，有点烦
let g:go_jump_to_error = 0
let g:go_metalinter_command = "golangci-lint run --new  --timeout=1m --issues-exit-code=-1 --disable-all -E=gosimple -E=unused -E=errcheck -E=staticcheck -E=ineffassign -E=govet -E=varcheck -E=structcheck -E=gocritic -E=dogsled -E=dupl -E=gosec -E=whitespace -E=funlen -E=unparam -E=golint -E=goimports -E=gofmt -E=lll -E=unconvert -E=misspell -E=scopelint -E=gocyclo -E=goconst -E=gochecknoinits -E=deadcode -E=stylecheck"
"=========================================
" coc 插件配置
"=========================================
" -------------------------------------------------------------------------------------------------
let g:coc_node_path = '/usr/bin/node'
"TextEdit sight fail if hidden is not set.
"在默认设置下，修改文件后打开新文件过程会显示有更改要保存
"使用:set hidden，当当前缓冲区未保存更改时打开新文件将导致文件被隐藏而不是关闭
"仍然可以通过键入:ls然后访问未保存的更改，然后输入，缓冲区的编号:b[N]
set hidden
"Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
"设置命令行的高度
set cmdheight=2
"如果过了这么多毫秒数以后还没有任何输入，把交换文件写入磁盘
set updatetime=300
"不给出 |ins-completion-menu| 信息。例如，
"-- XXX completion (YYY)"、"match 1 of 2"、"The only match"、
"Pattern not found"、"Back at original" 等等。
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>cm  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"=========================================
" vim-translator 插件配置
"=========================================
" Echo translation in the cmdline
nmap <silent> <leader>tc <Plug>Translate
vmap <silent> <leader>tc <Plug>TranslateV
" Display translation in a window
nmap <silent> <leader>tw <Plug>TranslateW
vmap <silent> <leader>tw <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV
" Translate the text in clipboard
nmap <silent> <Leader>tx <Plug>TranslateX

"=========================================
"  git-blame 插件配置
"=========================================
"查看git 行代码是谁写的
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

"=========================================
"  ultisnips 插件配置
"=========================================
let g:UltiSnipsExpandTrigger="<c-l>"

"=========================================
"  fzf 插件配置
"=========================================
"配置颜色
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment']
            \ }
"搜索文件名
nnoremap <C-f> :Files!<Cr>
"搜索结果
map <C-g> <Esc><Esc>:Rg!<space>
"搜索当前buffer的行
inoremap <C-g> <Esc><Esc>:BLines!<CR>
"展示当前buffer的提交
"map <C-c> <Esc><Esc>:BCommits!<CR>
"- 快捷键打开缓冲区列表
nnoremap - :Buffers<CR>
"############################################### enc 所有插件配置 ###############################
