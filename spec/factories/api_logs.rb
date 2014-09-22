# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_log do
    controller 'test_controller'
    action 'test_action'
    ip_address '127.0.0.1'
    path '/test'
    url 'http://test.test.com'
    request_method 'GET'
  end
end
