FactoryGirl.define do
  factory :episode do
    podcast
    title 'Video title'
    published_at Time.mktime(2017, 6, 25, 2, 20)
    media File.open(Rails.root.join('spec', 'fixtures', 'audio.mp3'))
  end
end
