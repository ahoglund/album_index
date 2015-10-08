FactoryGirl.define do
  factory :album do
    title Faker::Book.title
    artist
  end
end
