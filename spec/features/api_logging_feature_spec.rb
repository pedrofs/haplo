# require 'spec_helper'

# describe "logging feature", type: :api do
#   let(:user) { build(:logged_user) }
#   let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

#   context "authenticated" do
#     let!(:project) { create(:project) }

#     before :each do
#       set_header user
#     end

#     after :each do
#       set_header nil
#     end

#     it "should create the log file" do
#       get '/projects', format: :json

#       expect(File.exists?(File.join(::Rails.root, 'log/api', Rails.env, account.subdomain, "access.csv"))).to be(true)
#     end
#   end
# end