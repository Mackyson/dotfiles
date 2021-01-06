if has('vim_starting')
	set rtp+=~/.vim/plugged/vim-plug
	if !isdirectory(expand('~/.vim/plugged/vim-plug'))
		echo 'install vim-plug...'
		call system('mkdir -p ~/.vim/plugged/vim-plug')
		call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
		echo 'input ":PlugInstall" on your vim. '
	end
endif

"vim/plugがないとき用，ほぼコピペ
" TODO プラグイン周りを書き換えたあとは必ず:PlugInstallすること！

call plug#begin('~/.vim/plugged')
"プラグイン入れる(vim-plug)

Plug 'scrooloose/nerdtree'
" :NERDTree でディレクトリツリーを表示 Ctrl+W -> hjkl で分割画面を移動

Plug 'tomtom/tcomment_vim'
" Shift+vで行単位で選択->Ctrl+_を2回入力でコメントアウト

Plug 'Yggdroot/indentLine'
set tabstop=4
set shiftwidth=4
"インデント可視化
"うごきません

Plug 'bronson/vim-trailing-whitespace'
"行末の空白を可視化 :FixWhiteSpaceで削除可能

Plug 'tpope/vim-fugitive'
set statusline+=%{fugitive#statusline()}
"なんかGitいろいろ触れるらしいけどブランチ表示したいだけ，
"Git触るときはTigで．

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" let g:deoplete#enable_at_startup=1
" "コード補完

Plug 'lervag/vimtex'
Plug 'poppyschmo/deoplete-latex'
"texの補完

Plug 'fatih/vim-go'
Plug 'mattn/vim-goimports'
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
filetype plugin on
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
let g:deoplete#sources#go#gocode_binary = '/home/mackyson/go/bin/gocode'
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
"GoをIDEに

Plug 'rust-lang/rust.vim'
Plug 'sebastianmarkow/deoplete-rust'
"Rustの補完

Plug 'prettier/vim-prettier', {
	\'do': 'yarn install',
	\'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html']}
"JS用のコード整形
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
"TypeScriptのSystax highlight

Plug 'elzr/vim-json'
"jsonを見やすくする

Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.vue'
"閉じるタグを自動入力してくれる

Plug 'airblade/vim-gitgutter'
"更新箇所に+や-がつく

Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
"JK移動をもっと早く"

call plug#end()

set number
"行数表示

set title
"編集中のファイルのパスを表示

set autoread
"作業中のファイルの更新を自動で読み込み，いらない気もする．

set background=light
colorscheme darkblue
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
"配色をオタクに

set virtualedit=onemore
"行末の1文字先までカーソルを移動できるように

set scrolloff=12
"7行余裕を持ってスクロールするように

set nobackup
set noswapfile
"こいつらは邪魔

set cursorline
highlight CursorLine term=reverse cterm=none ctermbg=black
"現在の行を強調

nmap<Esc><Esc> :nohlsearch<CR><Esc>
"Escapeを二回押すと検索のハイライトを解除

set list listchars=tab:\.\.
"インデントを可視化，プラグインが動かなかったときにアンコメントしてね

let g:tex_conceal=''
"TeXの数式が自動でアレするのを防ぐ

autocmd BufWritePre * :FixWhitespace
"保存時に空白を削除

autocmd BufReadPost * :NERDTree
"起動時にNERDTreeを自動で開く

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
":qでNERDTreeも一緒に消す

if argc() == 0 || argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
		autocmd vimenter * NERDTree
else
		autocmd vimenter * NERDTree | wincmd p
	endif
"起動時にファイルの方にフォーカスをする，ただしディレクトリを開いたときはTreeにフォーカス
"正直<C_w>lが体に染み付いているので不要かも知れない

nnoremap あ a
nnoremap い i
nnoremap お o
nnoremap っｄ dd
nnoremap ：ｗ :w
nnoremap ：ｑ :q
nnoremap ：ｑ！ :q!
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
inoremap <Up> <nop>
inoremap <Down> <nop>
"日本語入力のままでも多少弄りやすいように

nmap <F5> <ESC>i<C-r>=strftime("%H:%M")<CR><CR><ESC><K>
imap <F5> <C-r>=strftime("%H:%M")<CR><CR>
"F5で現在時刻を入力
