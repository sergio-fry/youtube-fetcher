# Youtube Fetcher

[![Youtube Compatible](https://img.shields.io/badge/youtube-podcasting-brightgreen.svg)](http://yt.udalovs.ru)
[![Build Status](https://travis-ci.org/sergio-fry/youtube-fetcher.svg?branch=master)](https://travis-ci.org/sergio-fry/youtube-fetcher)
[![Code Climate](https://codeclimate.com/github/sergio-fry/youtube-fetcher.png)](https://codeclimate.com/github/sergio-fry/youtube-fetcher)
[![Test Coverage](https://codeclimate.com/github/sergio-fry/youtube-fetcher/badges/coverage.svg)](https://codeclimate.com/github/sergio-fry/youtube-fetcher/coverage)
[![Docker Pulls](https://img.shields.io/docker/pulls/udalov/youtube-fetcher.svg)](https://hub.docker.com/r/udalov/youtube-fetcher/)
[![license](https://img.shields.io/github/license/sergio-fry/youtube-fetcher.svg)](https://github.com/sergio-fry/youtube-fetcher)
[![Gitter](https://img.shields.io/gitter/room/youtube-fetcher/Lobby.svg)](https://gitter.im/youtube-fetcher/Lobby)

Convert Youtube channel into audio podcasts with 1 click. Free webservice is [available](http://yt.udalovs.ru). With *YF* you can listen to your favorite Youtube channels as audio podcasts offline. Choose any podcast player you want.

Try [Youtube Fetcher](http://yt.udalovs.ru) online.

![Form Example](form-example.png)

## Features

|          |  Youtube Fetcher                        |
|----------|-----------------------------------------|
:sparkles: | Build Atom feed podcast by a channel ID
:tv:       | Youtube channels support
:speaker:  | Playlists are supported too!
:rocket:   | Background media download
:radio:    | Video converted into audio
:ship:     | Ships as a Docker image
:metal:    | It's a Ruby on Rails application
:+1:       | Well tested

## Tips

  * to enable Video fetching type in rails console `Flipper.enable(:video)`

## Example

Let's turn [TEDx Talks into](https://www.youtube.com/channel/UCsT0YIqwnpJCM-mx7-gSA4Q) *podcast*:

http://yt.mazavr.com/channels/UCsT0YIqwnpJCM-mx7-gSA4Q

## Run

```bash
make up
```

Open browser:

http://0.0.0.0:3000/

## Test

```bash
make test
```

## Requirements

* Docker
* Docker Compose

## License

Youtube Fetcher is released under the MIT [License](http://www.opensource.org/licenses/MIT).
