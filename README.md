# 必要なもの

* Docker
* docker-compose
* makeコマンド

がインストールされてる Mac / Linux

# 使い方


### .env

PROJECT_NAMEの値を希望に合わせて編集
この値はnuxt.jsプロジェクトのディレクトリ名にもなる

```.dotenv
PROJECT_NAME=my_project
```

### Makefile

カスタム内容の指定(自動化)
create-nuxt-app実行時のオプション --answers で予めカスタム内容を指定
--answers のパラメータをJSON形式で指定
(作りたいアプリに応じて編集)

```makefile
...
...
create-nuxt-app:
	docker-compose exec dev bash -c 'create-nuxt-app $$PROJECT_NAME --answers "{ \
	\"name\": \"$$PROJECT_NAME\", \
	\"language\": \"ts\", \
	\"pm\": \"yarn\", \
	\"ui\": \"vuetify\", \
	\"features\": [\"axios\"], \
	\"linter\": [\"eslint\", \"prettier\"], \
	\"test\"  : \"jest\", \
	\"mode\"  : \"universal\", \
	\"target\"  : \"server\", \
	\"devTools\": [\"jsconfig.json\"] }" \
	'
...
...
```

`Makefile` > `docker-compose` > `bash -c` と入れ子

## コマンドインターフェースを起動

## ダウンロードしたフォルダの中に移動

```shell script
git clone からの
cd docker-nuxtjs
```

## 以下のコマンドを実行する．

```shell script
make init
```

成功すると下記の表示↓

```shell script
...
...
yarn run v1.22.4
$ eslint --ext .js,.vue --ignore-path .gitignore . --fix
Done in 24.57s.

🎉  Successfully created project my_project

  To get started:

	cd my_project
	yarn dev

  To build & start for production:

	cd my_project
	yarn build
	yarn start

  To test:

	cd my_project
	yarn test

docker-compose exec dev bash -c 'sed -i -e "s@export default {@export default {\n  telemetry: false,\n@g" $PROJECT_NAME/nuxt.config.js'
docker-compose exec -d dev bash -c 'cd $PROJECT_NAME && npm run dev'

$
```

## Nuxt.jsサンプルページが起動しているはず->アクセス

* http://localhost



本リポジトリ内の`app/`とdockerコンテナ内の`/work/app`が同期（ボリュームマウント）している．
-> 例えば

```
app/$PROJECT_NAME/pages/index.vue
```

を編集すれば、即座に↑のサンプルページに反映

## Dockerコンテナを停止する

```shell script
make stop
```

## Dockerコンテナを起動する

```shell script
make up
```

## Dockerコンテナを再ビルドする

```shell script
make remake
```

## Dockerコンテナに入る

```shell script
make in
```

※ Nuxt.jsプロジェクトの再作成はしない．Dockerコンテナとしての再ビルド

## 本一式を完全廃棄する

```shell script
make destroy
```

※ このコマンドだけではapp/や本一式の内容物をいきなり削除はしない
そのあと、ご自身の手で本一式のディレクトリを削除
