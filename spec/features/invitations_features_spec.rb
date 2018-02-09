require 'rails_helper'

describe 'invitations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    visit users_path
  end

  it 'show the owner in the authorized users list' do
    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_selector '.glyphicon-ok'
  end 

  describe 'when user is invited' do
    before do
      fill_in 'Email', with: 'carlosandrestorres28@gmail.com'
      click_button 'Invite User'
    end
    it 'shows invitation when user is invited' do
      expect(page).to have_content 'invitation email has been sent'
      expect(page).to have_content 'carlosandrestorres28@gmail.com'
      expect(page).to have_content 'Invitation Pending'
    end

    it 'allows user to accept invitation' do
      click_link 'Sign out'
      open_email 'carlosandrestorres28@gmail.com'
      visit_in_email 'Accept invitation'

      fill_in 'Name', with: 'Carlos'
      fill_in 'Password', with: 'pw'
      fill_in 'Password confirmation', with: 'pw'
      click_button 'Set my password'

      expect(page).to have_content 'You are now signed in'
    end
  end
end