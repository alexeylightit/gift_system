module RewardCondition
  class FreshUser < BaseCondition
    delegate :transactions, to: :user
    EXPIRE_DAYS = 60
    REQUIRED_AMOUNT = 1000

    private

    def condition?
      return if reward.gifted?
      return unless transactions.total_amount > REQUIRED_AMOUNT
      expired?
    end

    def expired?
      (transactions.first.created_at + EXPIRE_DAYS.days).past?
    end

  end
end