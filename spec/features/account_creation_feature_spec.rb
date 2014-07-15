require 'rspec_helper'

describe 'account creation' do
  it 'allows user to create account' do
    visit root_path
    click_link 'Create Account'

    fill_in 'Name', with: 'John'
    fill_in 'Email', with: 'johndo@email.com'
    fill_in 'Password', with: 'johndo@email.com'
    fill_in 'Password confirmation', with: 'johndo@email.com'
    fill_in 'Subdomain', with: 'johndo_domain'

    click_button 'Create account'

    expect(page).to have_content('Signed up successfully')
  end
end