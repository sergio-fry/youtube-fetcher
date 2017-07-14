test: build
	docker run --rm -t youtube-fetcher test

build:
	docker build -t youtube-fetcher .

run:
	docker run -e RAILS_ENV=production -e SECRET_KEY_BASE=ABC123 -p 3000:80 -t youtube-fetcher web

console:
	docker run -e RAILS_ENV=production -e SECRET_KEY_BASE=ABC123 -i -t youtube-fetcher bash
