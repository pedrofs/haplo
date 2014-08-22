# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    sequence(:subdomain) { |n| "subdomain#{n}" }
    association :owner, factory: :logged_user, strategy: :build

    factory :invalid_account do
      subdomain ''
    end

    factory :account_with_schema do
      after(:build) do |account|
        Apartment::Tenant.create account.subdomain
        Apartment::Tenant.switch account.subdomain
      end

      after(:create) do |account|
        Apartment::Tenant.reset
      end
    end
  end
end
