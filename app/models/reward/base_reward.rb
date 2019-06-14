# frozen_string_literal: true
module Reward
  class BaseReward
    attr_reader :user, :type, :amount

    def initialize(user:, type:, amount:)
      @user = user
      @amount = amount
      @type = type
    end

    def create!
      Gift.create(user: user, type: type, reward: reward_name, amount: amount)
    end

    def gifted_by_dates(start_date, end_date)
      gifted_reward.where(created_at: start_date..end_date)
    end

    def gifted?
      gifted_reward.exists?
    end

    def reward_name
      self.class.instance_variable_get :@reward
    end

    private

    def gifted_reward
      @gifted_reward ||= user.gifts.where(type: type)
    end
  end
end