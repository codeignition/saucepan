FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :user_id do |n|
    2000 + n
  end

  factory :user do
    email
    password 'test12345'
    password_confirmation 'test12345'
    sign_in_count 2
    ssh_key 'asdfghjk'
    login_name { email.split('@').first }
    name 'Shobhit Srivastava'
    user_id

    trait :admin do
      admin true
    end

    factory :admin, traits: [:admin]

    trait :newcomer do
      sign_in_count 0
      ssh_key nil
    end

    factory :newcomer, traits: [:newcomer]
  end
end
