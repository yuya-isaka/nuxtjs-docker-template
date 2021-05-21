# 必要

* Docker
* docker-compose
* make

# 使い方

## クローンしたフォルダの中に移動

```shell script
$ cd docker-nuxtjs
```

## .git削除

```shell script
$ rm -rf .git
```

## 以下のコマンド実行

```shell script
make init
```
成功すると下記表示↓

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

## Nuxt.jsサンプルページが起動しているはず

* http://localhost
- 本リポジトリ内の`app/`とdockerコンテナ内の`/work/app`が同期（ボリュームマウント）している．


# 開発流れ

## make init 後
```shell script
Makefileがあるディレクトリに移動

make up
make in
------------docker内-------------------
yarn install
exit
---------------------------------------
git pull origin master
git checkout -b feature/{yourname}/{branchname}
make run
```

## 2回目
```shell script
make up
make in
------------docker内-------------------
yarn install
exit
---------------------------------------
make run

* コード編集
* 確認: http://localhost

git add .
git commit -m "comment"
git push origin feature/yourname/branchname

make stop
```

# Docker操作

## Nuxtアプリ作成

```shell script
make init
```

## Dockerコンテナ起動

```shell script
make up
```

## Nuxtアプリ起動

```shell script
make run
```

## Dockerコンテナ停止

```shell script
make stop
```

## Dockerコンテナに入る

```shell script
make in
```

## Dockerコンテナ確認

```shell script
make ps
```

## Dockerコンテナlog確認

```shell script
make logs
```

## Dockerコンテナ削除

```shell script
make down
```

## Dockerコンテナ再起動

```shell script
make restart
```

## Dockerコンテナをイメージから再ビルド

```shell script
make remake
```

## 本一式を完全廃棄(コンテナとイメージ)

```shell script
make destroy

* このコマンドだけではapp/や本一式の内容物をいきなり削除はしない．自身の手で本一式のディレクトリを削除．
```

# ファイル説明

## .env

PROJECT_NAMEの値を希望に合わせて編集
この値はnuxt.jsプロジェクトのディレクトリ名にもなる

```.dotenv
PROJECT_NAME=my_project
```
## Makefile

create-nuxt-app実行時のオプション --answers で予めカスタム内容を指定

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
`Makefile` > `docker-compose` > `bash -c` と入れ子
```


