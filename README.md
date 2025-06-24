dotfiles
====

## Install

- まずは、ヘルプデスク苅谷さんにADの設定とかしてもらう
    - ADログイン確認
    - プロファイルのインストール

### AppleID設定

- mediba.jpのアカウントを作成
- クレジットカードの情報は、アカウント作成後に削除

### ログインパスワードの変更

- https://support.apple.com/ja-jp/guide/mac-help/mchlp1550/mac

### システムアップデート

- App Storeの各アプリ、OSをアップデート

### Xcode

- App StoreからDL、インストール
- Command Line Tool for Xcodeをインストール

```bash
$ xcode-select --install
$ sudo xcodebuild -license
agree
```

### システム環境設定

#### MenuMeters

- [セットアップ](https://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/)
- MenuMeters
	- CPU
		- CPUメータを表示: グラフ&パーセント
		- パーセント表示オプション: ユーザとシステム(小文字サイズ 小)
		- カラーオプション
			- ユーザを緑
	- ディスク
		- ディスクメータを表示: ディスクに矢印(大)
		- 更新間隔(秒): 1.0
	- メモリ
		- メモリメータを表示: 使用量/空き容量
	- ネットワーク
		- ネットワークメータを表示:矢印と通信速度

#### 日付と時刻

- NTPサーバを ntp.nict.jp に変更
- 時計の表示を デジタル時計 -> 秒を表示 -> 24時間表示にする

#### トラックパッド

- ポイントとクリック
    - タップでクリック(1本指でタップ)
    - 軌跡の速さ(目盛りを真ん中に)
- その他のジェスチャ
    - Mission Controll
        - 利用しない
    - アプリケーションExpose
        - 利用しない
    - Launchpad
        - 利用しない

#### Dock

- サイズ
    - 小に目盛りを寄せる
- 画面上の位置
    - 左
- Dockを自動的に隠す/表示
    - チェックする
- 起動中のアプリケーションをアニメーションで表示
    - チェックを外す
- 起動済みのアプリケーションにインジケータを表示
    - チェックを外す

#### キーボード

- キーボード
    - F1,F2などのすべてのキーを標準のファンクションキーとして使用
- ショートカット
    - Spotlight
        - Spotlight検索を表示
            Ctl + Space
        - Finderの検索ウィンドウを表示
            - チェックを外す
    - 入力ソース
        - 入力メニューの次のソースを選択
            - チェックを外す

### terminal

- 一般
    - Pro
- プロファイル
    - Proを選択
    - テキスト
        - テキスト
            - テキストをアンチエイリアス処理
            - 点滅テキストの使用を許可
            - ANSIカラーを表示
        - カーソル
            - ブロック
                - チェックを入れる
            - 点滅カーソル
                - チェックを入れる
    - ウィンドウ
        - ウィンドウサイズ
            - 列
                - 210
            - 行
                - 60
    - シェル
        - コマンドを実行
            - チェックを入れる
            - tmux を指定
        - シェルの終了時
            - シェルが正常に終了した場合は閉じる

### Google Chrome

- アカウント同期機能を利用

### SSH

```
$ ssh-keygen -t rsa -C kitada@mediba.jp
$ cp memo/ssh/config ~/.ssh/config
```

- 公開鍵をgithubとかbitbucketに登録する

### dotfiles

- cloneしておく

```bash
$ cd $HOME
$ git clone git@github.com:mediba-Kitada/dotfiles.git
```

### Karabiner

- Chromeを起動し、アプリケーションを[DL](https://pqrs.org/osx/karabiner/)
- 設定ファイルをコピー
	- `cp path/to/dotfiles/.config/karabiner/karabiner.json ~/.config.karabiner/karabiner.json`

#### FILCO Majestouch MINILA Air

- left_commandをlett_optionに変更
- left_optionをleft_commandに変更
- right_optionをright_commandに変更

### google日本語入力

- Homebrew(cask)で管理
- システム環境設定
    - キーボード
        - 入力ソース
            - ひらがな(Google)
            - 英数(Google)

### shifit

- 本家[https://github.com/fikovnik/ShiftIt]
- システム環境設定
    - セキュリティとプライバシー
        - プライバシー
            - shiftitのパスを指定し、制御を許可する
		- 一般
			- すべてのアプリケーションを許可

### homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# 各アプリケーションをインストール
$ cd $HOME/dotfiles
$ brew bundle
```

### go

```
$ cd $HOME/dotfiles
$ make go-install
$ bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```

### zsh

```bash
# ログインシェルをzshに変更
$ chsh -s /bin/zsh

$ cd $HOME/dotfiles
$ sh install.sh
$ source .zshrc
```

### powerline

- Python3系を利用

```zsh
# powerline-statusのインストール
$ pip3 install --user powerline-status
# powerline用フォントをインストール
$ cd $HOME/dotfiles
$ sh fonts/install.sh
```

- terminalのフォントを変更
    - プロファイル
        - Proを選択
        - テキスト
            - フォント
                - DejaVu Sans Mono for Powerline 
                - 13pt

### vim

#### ソースインストール
- 事前にxcodeをバージョンアップし、以下のコマンドを実行
```
sudo xcodebuilld -llicense
xcode-select --install
```

- 事前にHomebrewでpythonをバージョンアップしておく
```
brew install pipx
```
- venvでpythonバージョン及びパッケージ管理
```
python3 -m venv $HOME/.venv
source $HOME/.venv/bin/activate
pip3 install -r ~/dotfiles/python3/requirements.txt
```

- インストール
    - オプションは、適時修正
```
git fetch --all --prune
git co v9.0.2136
make distclean
./configure \
  --prefix=/opt/local \
  --with-features=huge \
  --enable-multibyte \
  --enable-terminal \
  --enable-cscope \
  --enable-fail-if-missing \
  --enable-perlinterp \
  --enable-luainterp --with-lua-prefix=/opt/homebrew/Cellar/lua/5.4.6 \
  --enable-rubyinterp --with-ruby-command=/opt/homebrew/opt/ruby/bin/ruby LDFLAGS='-L/opt/homebrew/Cellar/ruby/3.2.2_1/lib' \
  --enable-python3interp vi_cv_path_python3=$HOME/.venv/bin/python3 \
  CC=`which clang`

make

src/vim --version
VIM - Vi IMproved 9.0 (2022 Jun 28, compiled Nov 30 2023 12:35:23)
macOS version - arm64
Included patches: 1-2136
Compiled by kitada@tem21006
Huge version without GUI.  Features included (+) or not (-):
+acl               +file_in_path      +mouse_urxvt       -tag_any_white
+arabic            +find_in_path      +mouse_xterm       -tcl
+autocmd           +float             +multi_byte        +termguicolors
+autochdir         +folding           +multi_lang        +terminal
-autoservername    -footer            -mzscheme          +terminfo
-balloon_eval      +fork()            +netbeans_intg     +termresponse
+balloon_eval_term -gettext           +num64             +textobjects
-browse            -hangul_input      +packages          +textprop
++builtin_terms    +iconv             +path_extra        +timers
+byte_offset       +insert_expand     +perl              +title
+channel           +ipv6              +persistent_undo   -toolbar
+cindent           +job               +popupwin          +user_commands
-clientserver      +jumplist          +postscript        +vartabs
+clipboard         +keymap            +printer           +vertsplit
+cmdline_compl     +lambda            +profile           +vim9script
+cmdline_hist      +langmap           -python            +viminfo
+cmdline_info      +libcall           +python3           +virtualedit
+comments          +linebreak         +quickfix          +visual
+conceal           +lispindent        +reltime           +visualextra
+cryptv            +listcmds          +rightleft         +vreplace
+cscope            +localmap          +ruby              +wildignore
+cursorbind        +lua               +scrollbind        +wildmenu
+cursorshape       +menu              +signs             +windows
+dialog_con        +mksession         +smartindent       +writebackup
+diff              +modify_fname      +sodium            -X11
+digraphs          +mouse             +sound             -xattr
-dnd               -mouseshape        +spell             -xfontset
-ebcdic            +mouse_dec         +startuptime       -xim
+emacs_tags        -mouse_gpm         +statusline        -xpm
+eval              -mouse_jsbterm     -sun_workshop      -xsmp
+ex_extra          +mouse_netterm     +syntax            -xterm_clipboard
+extra_search      +mouse_sgr         +tag_binary        -xterm_save
-farsi             -mouse_sysmouse    -tag_old_static
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
       defaults file: "$VIMRUNTIME/defaults.vim"
  fall-back for $VIM: "/opt/local/share/vim"
Compilation: /usr/bin/clang -c -I. -Iproto -DHAVE_CONFIG_H -I/usr/local/opt/ruby/include -DMACOS_X -DMACOS_X_DARWIN -g -O2 -I/opt/homebrew/Cellar/libsodium/1.0.19/include -D_REENTRANT -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
Linking: /usr/bin/clang -L/opt/homebrew/Cellar/ruby/3.2.2_1/lib -L/usr/local/lib -o vim -lm -lncurses -L/opt/homebrew/Cellar/libsodium/1.0.19/lib -lsodium -liconv -framework AppKit -L/opt/homebrew/Cellar/lua/5.4.6/lib -llua5.4 -mmacosx-version-min=13.5 -fstack-protector-strong -L/opt/homebrew/opt/perl/lib/perl5/5.38/darwin-thread-multi-2level/CORE -lperl -L/opt/homebrew/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/lib/python3.11/config-3.11-darwin -lpython3.11 -framework CoreFoundation -lruby.3.2 -L/opt/homebrew/Cellar/ruby/3.2.2_1/lib

sudo make install
```

#### パッケージ管理
```zsh
# eslint-language-serverのインストール(グローバルで必要)
$ yarn global add typescript eslint
# deinのインストール
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/.cache/dein
$ pip3 install neovim

# vimを起動しdeinと各種LSPサーバの初期設定
:call dein#install()
:LspInstallServer vim-language-server
:LspInstallServer eslint-language-server
:LspInstallServer gopls
:LspInstallServer bash-language-server
```

### AWS

```
$ mkdir HOME/.aws
$ cp memo/aws/credentials $HOME/.aws/credentials
```

### git

- Git ignoreの設定

```
$ git config --global core.excludesfile ~/.gitignore
$ git config --global core.excludesfile
```


### node.js

- [nvm](https://github.com/nvm-sh/nvm)を[インストール](https://github.com/nvm-sh/nvm#git-install)
