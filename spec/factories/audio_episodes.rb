FactoryGirl.define do
  factory :audio_episode do
    podcast
    sequence(:title) { |n| "Video #{n}" }
    published_at { Time.now }
    media File.open(Rails.root.join('spec', 'fixtures', 'audio.mp3'))
    sequence(:origin_id) { |n| "ABC-#{n}" }
  end

  factory :episode, parent: :audio_episode do

  end
end
