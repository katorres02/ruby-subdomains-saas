require 'rails_helper'

describe 'subdomains' do
	it 'create new subdomain' do
		visit root_path

		fill_in 'Name', with: 'MySubdomain'
		click_button 'Create'
		expect(page).to have_content 'mysubdomain'
	end
end