test: buckets build exec-test

test-ci: buckets build start-db-and-wait exec-test


start-db-and-wait:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml up -d
	sleep 10

build:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml build test

exec-test:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm test


buckets:
	mkdir -p tmp/minio/youtube-podcasts
	mkdir -p tmp/minio/youtube-podcasts-test

