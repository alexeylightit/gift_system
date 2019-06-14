require 'rails_helper'
describe LoyaltyService do
  subject(:service) { described_class.new(user: gold_user) }
  let!(:default_loyalty) { Loyalty.find_by_type :default }
  let!(:gold_loyalty) { Loyalty.find_by_type :gold }
  let!(:platinum_loyalty) { Loyalty.find_by_type :platinum }
  let(:gold_user) { create(:user, loyalty: gold_loyalty[:type]) }
  let(:user_loyalty_type) { gold_user.loyalty.to_sym }

  context 'upgrade!' do

    it 'should be upgraded' do
      create(:point, :gifted, user: gold_user, amount: platinum_loyalty[:condition])
      expect { service.upgrade! }.to change { gold_user.loyalty }
      expect(user_loyalty_type).to eq(platinum_loyalty[:type])
    end

    it 'should not be downgraded' do
      expect { service.upgrade! }.not_to change { gold_user.loyalty }
    end

  end

  context 'set_by_points' do

    it 'should be upgraded' do
      expect { service.set_by_points(platinum_loyalty[:condition]) }.to change { gold_user.loyalty }
      expect(user_loyalty_type).to eq(platinum_loyalty[:type])
    end

    it 'should be downgraded' do
      expect { service.set_by_points(default_loyalty[:condition]) }.to change { gold_user.loyalty }
      expect(user_loyalty_type).to eq(default_loyalty[:type])
    end

  end


end