FactoryGirl.define do
  factory :group do
    name 'labour'

    trait :admin do
      name 'admin'
    end
  end
end
