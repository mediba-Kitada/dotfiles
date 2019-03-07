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
            - チェックを外す
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

- アカウント同期機能を利用

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

- Chromeを起動し、アプリケーションを[DL](https://pqrs.org/osx/karabiner/)
- システム環境設定
    - セキュリティとプライバシー
        - Karabinerの挙動を許可する

### google日本語入力

- Homebrew(cask)で管理
- システム環境設定
    - キーボード
        - 入力ソース
            - ひらがな(Google)
            - 英数(Google)

### shifit

- 本家[200~https://github.com/fikovnik/ShiftIt]
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

- pyenvはHomebrewで導入

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
$ rbenv install 2.5.3
# バージョンを固定
$ rbenv global 2.5.3
$ rbenv exec gem install bundler
$ rbenv exec bundle install
# リファレンスのダウンロード
$ rbenv exec bundle exec bitclust setup
```

### AWS

- 以下のファイルを移植

```
$HOME/.aws/credentials
$HOME/.ssh/config
```

- Opsworksを利用している場合は、SSH公開鍵を更新する

#### homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew tap b4b4r07/brionac
$ brew install brionac
```

#### shifit

- [最新版](https://github.com/fikovnik/ShiftIt/releases)のアーカイブをダウンロード
- 展開後は、`/Applications`にmvする

#### dotfiles

```bash
$ cd ~/
$ git clone git@github.com:mediba-Kitada/dotfiles.git
$ cd ~/dotfiles
$ ./install.sh
```

### git

- Git ignoreの設定

```
$ git config --global core.excludesfile ~/.gitignore
```
