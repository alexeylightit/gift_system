module RewardScenario
  class Birthday < Default

    private

    def condition?
      reward.gifted_by_dates(*year).exists?
    end

    def year
      [Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]
    end
  end
end