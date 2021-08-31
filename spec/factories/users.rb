FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "user name #{i}" }
  end
end
