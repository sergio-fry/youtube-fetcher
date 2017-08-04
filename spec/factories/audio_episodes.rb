FactoryGirl.define do
  factory :audio_episode do
    podcast
    title 'Video title'
    published_at Time.mktime(2017, 6, 25, 2, 20)
    media File.open(Rails.root.join('spec', 'fixtures', 'audio.mp3'))
    sequence(:origin_id) { |n| "ABC-#{n}" }
  end

  factory :episode, parent: :audio_episode do

  end
end
