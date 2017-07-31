class WelcomeController < ApplicationController
  def index
    podcast.episodes.create!(
      origin_id: '1212',
      title: 'efwe',
      published_at: Time.current,
      media: File.open(Rails.root.join('spec/fixtures/audio.mp3'))
    )

    render plain: 'OK'
  end

  private

  def podcast
    Podcast.first || Podcast.create(origin_id: 'ABC')
  end
end
