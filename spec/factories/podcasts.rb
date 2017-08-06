FactoryGirl.define do
  factory :podcast do
    title 'Some Podcast'
    sequence(:origin_id) { |n| "CHANNEL-ID-#{n}" }

    trait :playlist do
      source_type 'playlist'
    end
  end
end
