# Youtube Fetcher

[![Build Status](https://travis-ci.org/sergio-fry/youtube-fetcher.svg?branch=master)](https://travis-ci.org/sergio-fry/youtube-fetcher)
[![GitHub tag](https://img.shields.io/github/tag/sergio-fry/youtube-fetcher.svg)]()
[![Code Climate](https://codeclimate.com/github/sergio-fry/youtube-fetcher.png)](https://codeclimate.com/github/sergio-fry/youtube-fetcher)
[![Test Coverage](https://codeclimate.com/github/sergio-fry/youtube-fetcher/badges/coverage.svg)](https://codeclimate.com/github/sergio-fry/youtube-fetcher/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/sergio-fry/youtube-fetcher.svg)](https://gemnasium.com/github.com/sergio-fry/youtube-fetcher)


Convert your favourite Youtube channels into audio podcasts.

## Example

http://youtube-fetcher.herokuapp.com/channels/ABC123.atom


## Features

|          |  Youtube Fetcher                        |
|----------|-----------------------------------------|
:sparkles: | Build Atom feed podcast by a channel ID
:rocket:   | Background media download
:radio:    | Video converted into MP3 audio
:ship:     | Ships as a Docker image
:metal:    | It's a Ruby on Rails application
:+1:       | Well tested

## Setup

```bash
$ docker run -p "8647:80" --name yt-fetcher udalov/youtube-fetcher
```
