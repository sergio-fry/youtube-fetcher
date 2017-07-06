FactoryGirl.define do
  factory :podcast do
    sequence(:origin_id) { |n| "CHANNEL-ID-#{n}" }
  end
end
