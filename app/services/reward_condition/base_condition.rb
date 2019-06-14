module RewardCondition
  class BaseCondition
    attr_reader :user, :reward

    def initialize(user:, reward:)
      @user = user
      @reward = reward
    end

    def issue_reward!
      reward.create! if condition?
    end

    private

    def condition?
      false
    end
  end
end