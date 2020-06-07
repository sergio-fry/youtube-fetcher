test: build
	docker-compose -f docker-compose.test.yml run --rm sut

build:
	docker-compose build

up:
	docker-compose up web
