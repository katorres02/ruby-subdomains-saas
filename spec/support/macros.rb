def sign_user_in(user, opts = {})
	if opts[:subdomain]
  	visit new_user_session_url(subdomain: opts[:subdomain])
  else
  	visit new_user_session_path
  end
  fill_in 'Email', with: user.email
  fill_in 'Password', with: (opts[:password] || user.password)
  click_button 'Log in'
end

def set_subdomain(subdomain)
	Capybara.app_host = "http://#{subdomain}.example.com"
end