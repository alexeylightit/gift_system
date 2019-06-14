module RewardCondition
  class Points < Default
    delegate :points, to: :user
    REQUIRED_POINTS = 100

    private

    def condition?
      return if gifted_this_month?
      points.by_date(*month).total_amount >= REQUIRED_POINTS
    end

    def gifted_this_month?
      reward.gifted_by_dates(*month).exists?
    end

    def month
      [Time.zone.now.beginning_of_month, Time.zone.now.end_of_month]
    end
  end
end