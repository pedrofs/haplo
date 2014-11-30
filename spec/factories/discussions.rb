# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discussion do
    title "Test"
    content "Testing discussion"
    association :user, factory: :user, strategy: :build
  end
end
