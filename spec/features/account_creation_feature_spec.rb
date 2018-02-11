=begin
require 'rails_helper'

describe 'account creation' do
	let(:subdomain) { FactoryBot.generate(:subdomain) }
	before(:each) { sign_up(subdomain) }

	it 'allow users to create account' do
		expect(page.current_url).to include(subdomain)
		expect(Account.count).to eq(2) # the fist account is created in support/database_cleaner -> config.before(:suite)
	end

	it 'allow access of subdomain' do
		visit root_url(subdomain: subdomain)
		expect(page.current_url).to include(subdomain)
	end

	it 'allows account followup creation' do
		subdomain2 = "#{subdomain}2"
		sign_up(subdomain2)
		expect(page.current_url).to include(subdomain2)
		expect(Account.count).to eq(3)
	end

	it 'does not allow account creation on subdomain' do
		user = User.first
		subdomain = Account.first.subdomain
		sign_user_in(user, subdomain: subdomain)
		expect { visit new_account_url(subdomain: subdomain) }.to raise_error ActionController::RoutingError
	end

	def sign_up(subdomain)
		visit root_url(subdomain: false)
		click_link 'Create Account'

		fill_in 'Name', with: 'Carlos'
		fill_in 'Email', with: 'carlos@mail.com'
		fill_in 'Password', with: 'pw'
		fill_in 'Password confirmation', with: 'pw'
		fill_in 'Subdomain', with: subdomain
		click_button 'Create Account'
	end
end
=end