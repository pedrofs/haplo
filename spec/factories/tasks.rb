# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    title 'Task Title'
    description 'task description'
    association :task_status, factory: :task_status, strategy: :build
  end
end
