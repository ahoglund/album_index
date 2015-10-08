FactoryGirl.define do
  factory :song do
    title Faker::Hacker.adjective + " " + Faker::Hacker.noun + " " + Faker::Hacker.verb
    album
  end
end
