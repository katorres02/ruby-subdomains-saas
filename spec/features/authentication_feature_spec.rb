require 'rails_helper'

describe 'user authentication' do
  let(:user) { build(:user) } # one per example
  let!(:account) { create(:account_with_schema, owner: user) } # one for describe block

  it 'allow signin with valid credentials' do
    sign_user_in(user, subdomain: account.subdomain)
    expect(page).to have_content('Signed in successfully')
  end

  it 'does not allow signin with invalid credentials' do
    sign_user_in(user, subdomain: account.subdomain, password: 'wrong pw')
    expect(page).to have_content('Invalid Email or password')
  end

  it 'does not allow to sign in unless on subdomain' do
    expect { visit new_user_session_path }.to raise_error ActionController::RoutingError
  end

  it 'does not allow user from one sudomain to sign in on another subdomain' do
    user2    = build(:user)
    account2 = create(:account_with_schema, owner: user2)

    sign_user_in(user2, subdomain: account2.subdomain)
    expect(page).to have_content('Signed in successfully')

    sign_user_in(user2, subdomain: account.subdomain)
    expect(page).to have_content('Invalid Email or password')
  end

  it 'allows user to sign out' do
    sign_user_in(user, subdomain: account.subdomain)

    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully')
  end
end
