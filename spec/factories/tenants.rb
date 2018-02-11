FactoryBot.define do
  factory :tenant do
    sequence(:name) { |n| "subdomain#{n}" }

    factory :tenant_with_schema do
      after(:build) do |tenant|
        Apartment::Tenant.create(tenant.name)
        Apartment::Tenant.switch!(tenant.name)
      end
      after(:create) do |tenant|
        Apartment::Tenant.reset
      end
    end
  end
end
