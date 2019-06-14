require 'rails_helper'
RSpec.describe RewardCondition::Birthday do
  let(:reward) { create(:reward, user: user, type: :birthday) }
  let(:condition) { described_class.new(user: user, reward: reward) }

  context 'Users birthday' do
    let(:user) { create(:user, birth_date: Time.zone.now) }

    it 'should gift reward' do
      expect { condition.issue_reward! }.to change { user.gifts.count }
    end

    it 'should not gift reward if reward gifted this year' do
      create(:gift, user: user, reward: reward.reward_name, type: reward.type)
      expect { condition.issue_reward! }.not_to change { user.gifts.count }
    end
  end

  context 'Not users birthday' do
    let(:user) { create(:user, birth_date: Time.zone.now.tomorrow) }
    it 'should no gift reward' do
      expect { condition.issue_reward! }.not_to change { user.gifts.count }
    end
  end

end