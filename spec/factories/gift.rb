FactoryBot.define do
  factory :gift do
    user
    reward
    amount { 1 }

  end
end