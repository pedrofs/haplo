# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_phase do
    name 'Test Phase One'
    start_at "2014/01/05"
    end_at "2014/02/05"

    factory :project_phase_two do
      name 'Test Phase Two'
      start_at "2014/02/06"
      end_at "2014/03/06"
    end

    factory :invalid_project_phase do
      name 'Invalid Project Phase'
      start_at "2014/04/06"
      end_at "2014/03/06"
    end

    factory :project_phase_child_one do
      name 'One child'
      start_at "2014/01/06"
      end_at "2014/01/25"
    end

    factory :project_phase_invalid_child_one do
      name 'Invalid One child'
      start_at "2014/04/06"
      end_at "2014/05/25"
    end
  end
end




