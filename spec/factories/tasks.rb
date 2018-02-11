FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task#{n}" }
  end
end
