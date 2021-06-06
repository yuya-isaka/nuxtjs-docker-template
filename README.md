# Nuxt, Docker, 開発環境構築

# 必要

- Docker
- docker-compose
- make

# 使い方

## 1. git clone https://github.com/yuya-isaka/nuxtjs-docker-template.git

## 2. フォルダ名変更 (必須)

* このフォルダ名がDockerから認識される名前となる
* nuxtjs-docker-template -> {template-name}

## 3. フォルダに移動

```shell script
$ cd {template-name}
```

## 4. .git 削除 (必須)

```shell script
$ rm -rf .git
```

## 5. .env ファイルに「プロジェクト名」「コンテナ名」を設定

* 名前はキャメルケースでもスネークケースでも OK
* プロジェクト名は nuxt.js プロジェクトのディレクトリ名にもなる
* コンテナ名はDockerで作られるコンテナの名前

* 設定後は.envファイルを読み込み or コンソール再起動


```shell script
.env

PROJECT_NAME=nuxt-project
CONTAINER_NAME=nuxt-container
```

## 5. Docker イメージ，コンテナ & Nuxt プロジェクト作成

```shell script
$ make init
```

成功すると下記表示 ↓ (成功しなかったら井阪まで)

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
$
```

## Github プロジェクト作成 (app/{project-name}と同じ名前にするべし)

```
$ cd app/{project-name}
$ git init
$ git add .
$ git commit -m "first commit"
$ git remote {作成したリポジトリ名}
$ git push -u origin master

この後は,ブランチ切って機能ごとに開発
開発後,masterにマージ
```

## プロジェクト完成! やったね!

# 開発流れ

## make init 後

```shell script
プロジェクトフォルダに移動（Makefileがあるフォルダ）

$ make up
$ make start

-> app/{project-name}をローカルで開発

* http://localhost で確認
* 本リポジトリ内の`app/`と docker コンテナ内の`/work/app`が同期（ボリュームマウント）

->開発終わり

$ CTRL^C
$ make stop
```

# Docker 操作/一覧

## Nuxt アプリ作成

```shell script
make init
```

## Docker コンテナ起動

```shell script
make up
```

## Docker コンテナ入る & yarn install & yarn dev

```shell script
make start
```

## Docker コンテナ停止

```shell script
make stop
```

## Docker コンテナ確認

```shell script
make ps
```

## Docker コンテナ log 確認

```shell script
make logs
```

## Docker コンテナ入る

```shell script
make in
```

## Docker コンテナ削除

```shell script
make down
```

## Docker コンテナ削除＆再起動

```shell script
make restart
```

## 本一式を廃棄(イメージとコンテナ)

```shell script
make destroy

* このコマンドだけではapp/や本一式の内容物をいきなり削除はしない．
* 自身の手で本一式のディレクトリを削除．
```

## Docker コンテナをイメージから再ビルド

```shell script
make remake
```

## Nuxt アプリ起動

```shell script
make run
```

## Docker 内のプロジェクトで"yarn install"

```shell script
make install
```

# ファイル補足説明

## Makefile

create-nuxt-app 実行時のオプション --answers でカスタム内容を指定

```makefile
...
...
create-nuxt-app:
	docker-compose exec dev bash -c 'create-nuxt-app $$PROJECT_NAME --answers "{ \
	\"name\": \"$$PROJECT_NAME\", \
	\"language\": \"js\", \
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
