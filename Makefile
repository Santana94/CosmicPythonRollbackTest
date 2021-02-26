build:
	docker-compose build

up:
	docker-compose up -d

test: up
	docker-compose run --rm --no-deps --entrypoint=pytest api /tests/unit /tests/integration /tests/e2e

unit-tests:
	docker-compose run --rm --no-deps --entrypoint=pytest api /tests/unit

integration-tests: up
	docker-compose run --rm --no-deps --entrypoint=pytest api /tests/integration

e2e-tests: down up
	docker-compose run --rm --no-deps --entrypoint=pytest api /tests/e2e -vv

logs:
	docker-compose logs --tail=25 api redis_pubsub

down:
	docker-compose down --remove-orphans

all: down build up test
