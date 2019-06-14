# frozen_string_literal: true
class ResetPointsWorker < ApplicationWorker
  CYCLES = 2

  def perform
    User.all.each do |user|
      user.points.delete_all
      update_loyalty(user)
    end
  end

  private

  def update_loyalty(user)
    points = user.points.with_deleted.max_year_amount(*date_range)
    LoyaltyService.new(user: user).set_by_points(points)
  end

  def date_range
    current = Time.zone.now.beginning_of_year
    prev = current - CYCLES.years
    [prev, current]
  end
end
