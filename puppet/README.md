# 雑メモ

## Puppetの用語

### manifest
* システムのあるべき状態を記述したもの

### RAL (Resource Abstraction Layer)
* プラットフォーム固有の事情(yumコマンドなど)を抽象化して、差異を吸収する仕組み

### function
* 一般的なプログラミング言語の関数と同じ役割
* https://puppet.com/docs/puppet/5.3/function.html

### resource
* manifestに記述する「システムのあるべき状態」の構成要素
* `package`や`file`など、resourceの具体的な種類のことを、resource typeと呼ぶ
* resource typeは、全て小文字で記述する
* https://puppet.com/docs/puppet/5.3/type.html

### attributes
* resource内で、システムがどういう状態であるべきかを記述するために使用される

### dependency relationship
* システムを正しく起動させるために、resourceの適用順序に決まりがある関係のこと
* `require`、`->`を使う

```md
1. yumリポジトリを登録する
2. nginxパッケージをインストールする
3. 設定ファイルを配置する
4. サービスを起動する
```

### refresh relationship
* resourceの変更にともなって、再読み込みのようなアクションが必要になる関係のこと
* `notify`(通知する側の設定)、`subscribe`(通知される側の設定)、`~>`(通知される側の設定)を使うことで、関係を指定できる 

```
1. 設定ファイルのresourceで`notify`を使う
2. 設定ファイルに変更があった場合に、refresh eventを通知する
3. 通知を受け取ったサービス設定のresourceで、再起動を行う
```

### Resource Reference
* 他のresourceへの参照のこと
* resource typeは、頭文字を大文字で記述する (宣言時はすべて小文字、それ以外は頭文字を大文字にすると覚える)

### class
* 各種resourceをグルーピングして、より構造化された記述のために使われるもの

### module
* ファイル群を分類・整理するための仕組み
* classの含まれる様々なファイルや、それらのclassが必要とするテンプレートなどをひとまとめに管理するために存在する
* module内に含むことができるディレクトリには以下の種類がある 
  * https://puppet.com/docs/puppet/5.3/modules_fundamentals.html
  * https://qiita.com/takeuchikzm/items/6b65af9e0cf8d317c9b3#module%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E6%A7%8B%E6%88%90


例

```
* moduleのディレクトリ名をmoduleと同名にする
* manifestを配置するディレクトリ名はmanifestsにする
* templateを配置するディレクトリ名はtemplatesにする
```

manifestsの例
* class名とファイル名を一致させることで、`include module名::class名` と書くだけで自動的にロードできる

```
* moduleと同名のclassについてはinit.ppというファイル名にする
* その他のclassについてはモジュール名::以降をファイル名と対応させる
* 各ファイルにはただひとつだけclassを含めることができる
```

### `::クラス名`
* `::nginx`のように、`::`と先頭につけているのは、名前空間のトップレベルから名前解決を行うという意味 (Rubyにおけるmoduleの名前解決と同様の仕組み)
* カレントのコンテキストとは違う階層にある別のclassをincludeする際は、明示的にトップレベルから指定することで、思わぬハマりどころを避けられる

---

## コマンドラインのオプション

### --modulepath 
* moduleの格納されているパスを指定する

### --execute
* manifestファイルに書かれたもの同様に、Puppetの記述を実行することができる



