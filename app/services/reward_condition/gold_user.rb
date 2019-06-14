# frozen_string_literal: true
module RewardCondition
  class GoldUser < BaseCondition

    private

    def condition?
      return unless user.gold?
      reward.gifted?
    end
  end
end