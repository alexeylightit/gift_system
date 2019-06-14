module RewardCondition
  class Default
    attr_reader :user, :reward

    def initialize(user:, reward:)
      @user = user
      @reward = reward
    end

    def issue_reward!
      puts "Creating reward: #{reward}"
      puts "condition: #{condition?}"
      reward.create! if condition?
    end

    private

    def condition?
      false
    end
  end
end