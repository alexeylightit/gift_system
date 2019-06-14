FactoryBot.define do
  factory :reward, class: Reward::BaseReward do
    user
    reward { 'Test reward' }
    type { 'test' }
    amount { 1 }
    skip_create
    initialize_with { new(user: attributes[:user], type: attributes[:type], amount: attributes[:amount]) }
  end
end