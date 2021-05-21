init:
	docker-compose up -d --build
	docker-compose exec dev bash -c 'yarn global add create-nuxt-app'
	@make create-nuxt-app
	docker-compose exec dev bash -c 'sed -i -e "s@export default {@export default {\n  telemetry: false,\n@g" $$PROJECT_NAME/nuxt.config.js'
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

up:
	docker-compose up -d
start:
	docker-compose exec dev bash -c 'cd $$PROJECT_NAME && yarn install && yarn dev'
stop:
	docker-compose stop

ps:
	docker-compose ps
logs:
	docker-compose logs

down:
	docker-compose down
restart:
	@make down
	@make up

destroy:
	docker-compose down --rmi all --volumes
remake:
	@make destroy
	docker-compose build --no-cache --force-rm
	@make up

install:
	docker-compose exec -d dev bash -c 'cd $$PROJECT_NAME && yarn install'
run:
	docker-compose exec -d dev bash -c 'cd $$PROJECT_NAME && yarn dev'