dotfiles
====

## Install

- まずは、ヘルプデスク苅谷さんにADの設定とかしてもらう
    - ADログイン確認
    - プロファイルのインストール

### AppleID設定

- mediba.jpのアカウントを作成
- クレジットカードの情報は、アカウント作成後に削除

### システムアップデート

- App Storeの各アプリ、OSをアップデート

### Xcode

- App StoreからDL、インストール
- Command Line Tool for Xcodeをインストール

```bash
$ xcode-select --install
$ sudo xcrun cc
agree
```

### システム環境設定

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
            Option + Space
        - Finderの検索ウィンドウを表示
            Controll + Option + Space
    - 入力ソース
        - 前の入力ソースを選択
            - チェックを外す
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

- [Share Extensions](https://chrome.google.com/webstore/detail/share-extensions/chdafcbnfkfenoeejpaeenpdamhmalhe)でExtensions一覧をエクスポート
- ブックマークをHTMLファイルで出力、pandocでmarkdownファイルに変換
- safariを起動して手動でインストール
- chromeをデフォルトのブラウザに設定
- エクスポートしたmarkdownファイルをプレビューモードで開き、Extensionsをインストールしていく
- markdownファイルをHTMLに変換し、インポート

### SSH

```
$ ssh-keygen -t rsa -C kitada@mediba.jp
```

- 公開鍵をgithubとかbitbucketに登録する

### dotfiles

- cloneしておく

```bash
$ cd $HOME
$ git clone git@github.com:mediba-Kitada/dotfiles.git
```

### Karabiner

- Chromeを起動し、アプリケーションをDL
    https://pqrs.org/osx/karabiner/index.html.ja
- システム環境設定
    - セキュリティとプライバシー
        - プライバシー
            - Karabinerのパスを指定し、制御を許可する
            - Karabiner_AZNotfilterを指定し、制御を許可する

- 既存Macで設定をexport

```bash
$ /Applications/Karabiner.app/Contents/Library/bin/karabiner export > ~/dotfiles/karabiner.sh
```

- KarabinerをGUIで開く
- 移行先Macに設定をimport

```
$ ~/dotfiles/karabiner.sh
```

### google日本語入力

- https://tools.google.com/dlpage/japaneseinput/eula.html?platform=mac&hl=ja
- システム環境設定
    - キーボード
        - 入力ソース
            - ひらがな(Google)
            - 英数(Google)

### shifit

- http://shift-it.en.softonic.com/mac
- システム環境設定
    - セキュリティとプライバシー
        - プライバシー
            - shiftitのパスを指定し、制御を許可する
		- 一般
			- すべてのアプリケーションを許可

### homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# brionacのインストール
$ brew tap b4b4r07/brionac
$ brew install brionac
# 各CLIアプリケーションをインストール
$ cd $HOME/dotfiles
$ brionac a
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

前述の ```dotfiles/install.sh``` でインストールを実施しているが動作していないので、手動で実行

```zsh
# pipのインストール
$ anyenv install pyenv && source ~/.zshrc
$ pip install --upgrade pip
# pipは標準pythonに付属しているはずだが、付属していない場合は手動でインストール
$ curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
# powerline-statusのインストール
$ pip install --user powerline-status
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

前述の ```brionac a``` でvimをluajitでインストールしているが、luaがサポートされないので、手動で対応

```zsh
$ brew uninstall vim
$ brew reinstall vim --with-lua
$ vi --version|grep +lua
```

#### vim-go

```
$ cd $HOME
$ vi
:GoInstallBinaries
```

### ruby

前述の ```dotfiles/install.sh``` でインストールを実施しているが動作していないので、手動で実行

```zsh
# rbenvのインストール
$ anyenv install rbenv && source ~/.zshrc
$ rbenv install 2.2.3
$ rbenv exec bundle exec bitclust setup
# バージョンを固定
$ rbenv global $RUBY_VERSION
```

### VirtualBox

- https://www.virtualbox.org/ 
- pkgファイrを解答してくれないので、CLI

```zsh
$ sudo installer -package /Volumes/VirtualBox/VirtualBox.pkg -target /
$ source ~/.zshrc
```

### Vagrant

- https://www.vagrantup.com/
- pkgファイルを解凍ししてくれないので、CLI

```zsh
$ sudo installer -package /Volumes/Vagrant/Vagrant.pkg -target /
$ source ~/.zshrc
```

### AWS

- 以下のファイルを移植

```
$HOME/.aws/credentials
$HOME/.ssh/config
```

- Opsworksを利用している場合は、SSH公開鍵を更新する

### 複合機

- ドライバのDL及びインストール
	- http://www.konicaminolta.jp/business/download/copiers/bizhub_c554_c454/ps/detail_mac_osx109.html
- システム環境設定での操作
	- プリントとスキャン >> プリンタの追加 >> IP
	- アドレス：IPアドレスを入力（複合機2は192.168.3.246）
	- プロトコル：LPDを選択 （※IPPを選択したら印刷できませんでした）
	- ドライバ：「KONICA MINOLTA C554 PS」を選択
- 給紙ユニット：なし
- 廃紙ユニット：なし
- パンチキット：なし
- ハードディスク：チェックあり
- セキュリティ印刷のみ許可：チェックあり
- パブリックユーザーを許可：チェックなし
- 部門管理
	- 部門名:ブランク
	- パスワード:0500
- セキュリティ印刷
	- ID:社員番号
	- パスワード:適当
#### google日本語入力

https://tools.google.com/dlpage/japaneseinput/eula.html?platform=mac&hl=ja

#### homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew tap b4b4r07/brionac
$ brew install brionac
```

#### shifit

http://shift-it.en.softonic.com/mac

#### dotfiles

```bash
$ cd ~/
$ git clone git@github.com:mediba-Kitada/dotfiles.git
$ cd ~/dotfiles
$ ./install.sh
```

#### zsh

```bash
$ source ~/.zshrc
```

#### vim

```zsh
$ brew uninstall vim
$ brew reinstall vim --with-lua
```

#### Ruby

```bash
# リファレンスのダウンロード
$ rbenv exec bundle exec bitclust setup
```

