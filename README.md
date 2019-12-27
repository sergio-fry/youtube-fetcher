# Youtube Fetcher

[![Build Status](https://travis-ci.org/sergio-fry/youtube-fetcher.svg?branch=master)](https://travis-ci.org/sergio-fry/youtube-fetcher)
[![Code Climate](https://codeclimate.com/github/sergio-fry/youtube-fetcher.png)](https://codeclimate.com/github/sergio-fry/youtube-fetcher)
[![Test Coverage](https://codeclimate.com/github/sergio-fry/youtube-fetcher/badges/coverage.svg)](https://codeclimate.com/github/sergio-fry/youtube-fetcher/coverage)
[![Docker Pulls](https://img.shields.io/docker/pulls/udalov/youtube-fetcher.svg)](https://hub.docker.com/r/udalov/youtube-fetcher/)
[![license](https://img.shields.io/github/license/sergio-fry/youtube-fetcher.svg)](https://github.com/sergio-fry/youtube-fetcher)
[![Gitter](https://img.shields.io/gitter/room/youtube-fetcher/Lobby.svg)](https://gitter.im/youtube-fetcher/Lobby)

Convert Youtube channel into audio podcasts with 1 click. With *YF* you can listen to your favorite Youtube channels as audio podcasts offline. Choose any podcast player you want.


![Form Example](form-example.png)

## Features

|          |  Youtube Fetcher                        |
|----------|-----------------------------------------|
:sparkles: | Build Atom feed podcast by a channel ID
:tv:       | Youtube channels support
:speaker:  | Playlists are supported too!
:rocket:   | Background media download
:radio:    | Video converted into MP3 audio
:ship:     | Ships as a Docker image
:metal:    | It's a Ruby on Rails application
:+1:       | Well tested

## Tips

  * to enable Video fetching type in rails console `Flipper.enable(:video)`


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
