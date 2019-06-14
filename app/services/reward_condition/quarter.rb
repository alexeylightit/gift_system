module RewardCondition
  class Quarter < BaseCondition
    delegate :points, :transactions, to: :user
    REQUIRED_AMOUNT = 2000

    def issue_reward!
      add_points if super
    end

    private

    def condition?
      return if reward.gifted_by_dates(*quarter).exists?
      transactions.by_date(*quarter).total_amount > REQUIRED_AMOUNT
    end

    def add_points
      PointsService.new(user).add_points(amount: reward.amount, reason: reward)
    end

    def quarter
      [Time.zone.now.beginning_of_month, Time.zone.now.end_of_month]
    end
  end
end