# Youtube Fetcher

[![Build Status](https://travis-ci.org/sergio-fry/youtube-fetcher.svg?branch=master)](https://travis-ci.org/sergio-fry/youtube-fetcher)

[![GitHub tag](https://img.shields.io/github/tag/sergio-fry/youtube-fetcher.svg)]()
[![Gemnasium](https://img.shields.io/gemnasium/mathiasbynens/he.svg)]()
[![Github file size](https://img.shields.io/github/size/webcaetano/craft/build/craft.min.js.svg)]()
[![Docker Build Statu](https://img.shields.io/docker/build/jrottenberg/ffmpeg.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/AFNetworking.svg)]()

TODO: coverage, up-to-date, code quality, heroku install, MIT License

Convert your favourite Youtube channels into audio podcasts.

## Example

http://youtube-fetcher.herokuapp.com/channels/ABC123.atom


## Features

* Build Atom feed podcast by a channel ID
* Background media download
* Converting audio to MP3
* Written on Ruby on Rails
* Ships as a Docker image



|          |  fastlane  |
|----------|------------|
:sparkles: | Connect iOS and Android build tools into one workflow (both _fastlane_ tools and third party tools)
:monorail: | Define different `deployment lanes` for App Store deployment, beta builds, or testing
:ship: | Deploy from any computer, including a CI server
:wrench: | Extend and customise functionality
:thought_balloon: | Never remember any difficult commands, just `fastlane`
:tophat: | Easy setup assistant to get started in a few minutes
:email: | Automatically pass on information from one build step to another (*e.g.* path to the `ipa` file)
:page_with_curl: | Store **everything** in Git. Never lookup build commands on your CI system again.
:rocket: | Saves you **hours** for every app update you release
:pencil2: | Flexible configuration using a fully customisable `Fastfile`
:mountain_cableway: | Implement a fully working Continuous Delivery process
:ghost: | [Jenkins Integration](https://docs.fastlane.tools/best-practices/continuous-integration/#jenkins-integration): Show output directly in test results
:book: | Automatically generate Markdown documentation of your lane configurations
:hatching_chick: | Over 170 built-in integrations and 170 plugins available
:computer: | Support for iOS and Android apps
:octocat: | Full Git and Mercurial support

## Usage

TODO

## Setup

```bash
$ docker run -p "8647:80" --name yt-fetcher udalov/youtube-fetcher
```
