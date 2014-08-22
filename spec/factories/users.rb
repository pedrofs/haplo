# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Pedro'
    sequence(:email) { |n| "email#{n}@email.com.br" }
    password 'p4ssw0rd'

    factory :logged_user do
      email 'logged@email.com.br'
      authentication_token 'logged_in_user'
    end

    factory :invited_user do
      name ''
      password ''
      email 'invited@user.com'
      invitation_token Devise.token_generator.generate(User, :invitation_token).first
      invitation_created_at Time.now
    end
  end
end
