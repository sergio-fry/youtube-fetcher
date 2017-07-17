# Youtube Fetcher

[![Youtube Compatible](https://img.shields.io/badge/youtube-podcasting-brightgreen.svg)](http://youtube-fetcher.russianpulse.ru)
[![Build Status](https://travis-ci.org/sergio-fry/youtube-fetcher.svg?branch=master)](https://travis-ci.org/sergio-fry/youtube-fetcher)
[![Code Climate](https://codeclimate.com/github/sergio-fry/youtube-fetcher.png)](https://codeclimate.com/github/sergio-fry/youtube-fetcher)
[![Test Coverage](https://codeclimate.com/github/sergio-fry/youtube-fetcher/badges/coverage.svg)](https://codeclimate.com/github/sergio-fry/youtube-fetcher/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/sergio-fry/youtube-fetcher.svg)](https://gemnasium.com/github.com/sergio-fry/youtube-fetcher)
[![Docker Pulls](https://img.shields.io/docker/pulls/udalov/youtube-fetcher.svg)](https://hub.docker.com/r/udalov/youtube-fetcher/)
[![license](https://img.shields.io/github/license/sergio-fry/youtube-fetcher.svg)](https://github.com/sergio-fry/youtube-fetcher)

Convert Youtube channel into audio podcasts with 1 click. Free webservice is [available](http://youtube-fetcher.russianpulse.ru). With *YF* you can listen to your favorite Youtube channels as audio podcasts offline. Choose any podcast player you want.

Try [Youtube Fetcher](http://youtube-fetcher.russianpulse.ru/) online.

![Form Example](form-example.png)

## Features

|          |  Youtube Fetcher                        |
|----------|-----------------------------------------|
:sparkles: | Build Atom feed podcast by a channel ID
:rocket:   | Background media download
:radio:    | Video converted into MP3 audio
:ship:     | Ships as a Docker image
:metal:    | It's a Ruby on Rails application
:+1:       | Well tested

## Example

Let's turn [TEDx Talks into](https://www.youtube.com/channel/UCsT0YIqwnpJCM-mx7-gSA4Q) *podcast*:

http://youtube-fetcher.russianpulse.ru/channels/UCsT0YIqwnpJCM-mx7-gSA4Q


## Setup

```bash
docker run -e RAILS_ENV=production -e SECRET_KEY_BASE=ABC123 -p 3000:80 -t udalov/youtube-fetcher web
```

Open browser:

http://0.0.0.0:3000/

## License

Youtube Fetcher is released under the MIT [License](http://www.opensource.org/licenses/MIT).
