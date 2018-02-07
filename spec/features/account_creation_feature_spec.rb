require 'rails_helper'

describe 'account creation' do
	it 'allow users to create account' do
		visit root_path
		click_link 'Create Account'

		#fill_in 'Name', with: 'Carlos'
		#fill_in 'Email', with: 'carlos@mail.com'
		#fill_in 'Password', with: 'pw'
		#fill_in 'Password Confirmation', with: 'pw'
		fill_in 'Subdomain', with: 'test_subdomain'

		click_button 'Create Account'

		expect(page).to have_content('Signed up successfully')
	end
end