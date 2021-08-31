FactoryBot.define do
  factory :post do
    sequence(:title) { |i| "title #{i}" }
    posted_at        { Time.zone.now }
  end
end
