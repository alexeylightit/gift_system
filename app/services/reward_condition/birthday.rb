# frozen_string_literal: true
module RewardCondition
  class Birthday < BaseCondition

    private

    def condition?
      return if reward.gifted_by_dates(*year).exists?
      user.birth_day.today?
    end

    def year
      [Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]
    end
  end
end