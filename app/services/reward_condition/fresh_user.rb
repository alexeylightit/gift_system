module RewardScenario
  class FreshUser < Default
    delegate :transactions, to: :user
    EXPIRE_DAYS = 60
    REQUIRED_AMOUNT = 1000

    private

    def condition?
      return if reward.gifted?
      return unless fresh_user?
      transactions.total_amount > REQUIRED_AMOUNT
    end

    def fresh_user?
      (transactions.first.created_at + EXPIRE_DAYS.days).past?
    end

  end
end