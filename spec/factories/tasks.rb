# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    title 'Task Title'
    description 'task description'

    association :assigned, factory: :user, strategy: :build
    association :reporter, factory: :user, strategy: :build
    association :taskable, factory: :project, strategy: :build

    factory :task_with_users_and_project do
    end
  end
end
