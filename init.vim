"set this at ~/.config/nvim/

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

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
let g:deoplete#enable_at_startup=1
"コード補完

Plug 'prettier/vim-prettier', {
	\'do': 'yarn install',
	\'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html']}
"JS用のコード整形

Plug 'airblade/vim-gitgutter'
"更新箇所に+や-がつく
"うごきません

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
"配色をオタクに

set whichwrap=b,s,h,l,<,>,[,]
"カーソル移動を直感的に

set virtualedit=onemore
"行末の1文字先までカーソルを移動できるように

set nobackup
set noswapfile
"こいつらは邪魔なので

set cursorline
"現在の行を強調

nmap<Esc><Esc> :nohlsearch<CR><Esc>
"Escapeを二回押すと検索のハイライトを解除

set list listchars=tab:\.\.
"インデントを可視化，プラグインが動かなかったときにアンコメントしてね

autocmd BufWritePre * :FixWhitespace
"保存時に空白を削除

autocmd BufReadPost * :NERDTree
"起動時にNERDTreeを自動で開く

autocmd QuitPre * :qall
":qでNERDTreeも一緒に消す(かなり強引)

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
"最後にカーソルがあった場所から開始する
