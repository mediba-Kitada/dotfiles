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

```zsh
# eslint-language-serverのインストール(グローバルで必要)
$ yarn global add typescript eslint
# deinのインストール
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/.cache/dein
# vimを起動しdeinとvim-lsp-settingsの初期設定
:call dein#install()
:LspInstallServer eslint-language-server
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

### go

```
# realizeのインストール
$ go get github.com/oxequa/realize
# goimportsのインストール
$ go get golang.org/x/tools/cmd/goimports
```
