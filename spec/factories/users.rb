FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password 'test12345'
    password_confirmation 'test12345'
    sign_in_count 2

    trait :admin do
      admin true
    end

    factory :admin, traits: [:admin]

    trait :newcomer do
      sign_in_count 0
      key nil
    end

    factory :newcomer, traits: [:newcomer]
  end
end
