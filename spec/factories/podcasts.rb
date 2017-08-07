FactoryGirl.define do
  factory :podcast do
    title 'Some Podcast'
    sequence(:origin_id) { |n| "CHANNEL-ID-#{n}" }
    accessed_at { Time.now }

    trait :playlist do
      source_type 'playlist'
    end
  end
end
