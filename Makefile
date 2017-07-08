test: buckets
	docker-compose -f docker-compose.yml -f docker-compose.test.yml build test
	docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm test

buckets:
	mkdir -p tmp/minio/youtube-podcasts
	mkdir -p tmp/minio/youtube-podcasts-test

