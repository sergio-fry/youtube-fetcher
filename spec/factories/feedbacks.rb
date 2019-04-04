FactoryGirl.define do
  factory :feedback do
    email "foo@example.com"
    title "MyString"
    body "MyText"
    category "common"
  end
end
