# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timelog do
    association :task, factory: :task, strategy: :build
    association :user, factory: :user, strategy: :build
    content 'test'
    started_at { Time.now - 1.hour }

    factory :timelog_stopped do
      stopped_at { Time.now }
    end
  end
end
