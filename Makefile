up:
	docker-compose up -d
start:
	@make up
in:
	docker-compose exec dev bash
init:
	docker-compose up -d --build
	docker-compose exec dev bash -c 'yarn global add create-nuxt-app'
	@make create-nuxt-app
	docker-compose exec dev bash -c 'sed -i -e "s@export default {@export default {\n  telemetry: false,\n@g" $$PROJECT_NAME/nuxt.config.js'
	@make run-dev
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
run-dev:
	docker-compose exec -d dev bash -c 'cd $$PROJECT_NAME && yarn dev'
remake:
	@make destroy
	docker-compose build --no-cache --force-rm
	docker-compose up -d
	@make run-dev
stop:
	docker-compose stop
down:
	docker-compose down
restart:
	@make down
	@make up
destroy:
	docker-compose down --rmi all --volumes
destroy-volumes:
	docker-compose down --volumes
ps:
	docker-compose ps
logs:
	docker-compose logs
logs-watch:
	docker-compose logs --follow
# sh-dev:
# 	docker-compose exec dev bash
re-dev:
	docker-compose build dev
	docker container stop dev
	docker container rm dev
	docker-compose up -d --build dev
rmc:
	docker container rm `docker container ls -aq`
