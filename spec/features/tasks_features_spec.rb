require 'rails_helper'

describe 'tasks' do
	let!(:tenant) { create(:tenant) }
	
	it 'tasks url contains subdomain name' do
		visit tasks_url(subdomain: tenant.name)
		expect(page.current_url).to include(tenant.name)
	end

	it 'create task inside subdomain' do
		visit tasks_url(subdomain: tenant.name)

		fill_in 'Name', with: 'MyTask'
		click_button 'Create'
		expect(page).to have_content 'MyTask'
	end
end