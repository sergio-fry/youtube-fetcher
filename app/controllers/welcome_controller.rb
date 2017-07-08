class WelcomeController < ApplicationController
  def index
    Podcast.first.episodes.create!(
      origin_id: '1212',
      title: 'efwe',
      published_at: Time.now,
      media: File.open(Rails.root.join('spec/fixtures/audio.mp3'))
    )

    render plain: 'OK'
  end
end
