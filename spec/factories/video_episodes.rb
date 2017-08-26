FactoryGirl.define do
  factory :video_episode do
    podcast
    title 'Video title'
    published_at { Time.now }
    media File.open(Rails.root.join('spec', 'fixtures', 'video.mp4'))
    sequence(:origin_id) { |n| "ABC-#{n}" }
  end
end
