RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    # Truncating doesn't drop schemas, ensure we're clean here, app *may not* exist
    Apartment::Tenant.drop('app') rescue nil
    # Create the default tenant for our tests
    user = User.create(name: 'test', email: 't@ma.com', password: 'pw')
    Account.create(subdomain: 'app', owner: user)
    Apartment::Tenant.create('app')
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
    # Switch into the default tenant
    Apartment::Tenant.switch! 'app'
  end

  config.after(:each) do
    # Reset tentant back to `public`
    Apartment::Tenant.reset

    DatabaseCleaner.clean
  end
end