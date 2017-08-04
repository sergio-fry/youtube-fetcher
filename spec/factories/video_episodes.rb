FactoryGirl.define do
  factory :video_episode do
    podcast
    title 'Video title'
    published_at Time.mktime(2017, 6, 25, 2, 20)
    media File.open(Rails.root.join('spec', 'fixtures', 'video.mp4'))
    sequence(:origin_id) { |n| "ABC-#{n}" }
  end
end
