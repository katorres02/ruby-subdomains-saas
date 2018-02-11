=begin
FactoryBot.define do
  factory :user do
  	name 'Carlos'
    sequence(:email) { |n| "#{n}@mail.com" }
    password 'pw'
  end
end
=end