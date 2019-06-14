FactoryBot.define do
  factory :point do
    user
    amount { 0 }

    trait :gifted do
      reason { create(:gift, user: user, amount: amount) }
    end

  end
end