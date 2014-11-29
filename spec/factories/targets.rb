# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :target do
    association :discussion, factory: :discussion, strategy: :build

    factory :project_target do
      association :targetable, factory: :project, strategy: :build
    end

    factory :task_target do
      association :targetable, factory: :task, strategy: :build
    end
  end
end
