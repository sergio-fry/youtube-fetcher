FactoryGirl.define do
  factory :podcast do
    sequence(:origin_id) { |n| "CHANNEL-ID-#{n}" }

    trait :playlist do
      source_type 'playlist'
    end
  end
end
