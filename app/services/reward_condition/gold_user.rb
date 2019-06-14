module RewardCondition
  class Loyalty < Default

    private

    def condition?
      return unless user.gold?
      reward.gifted?
    end
  end
end