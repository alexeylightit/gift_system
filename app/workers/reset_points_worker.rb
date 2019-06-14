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
    points = total_points(user)
    LoyaltyService.new(user).set_by_points(points)
  end

  def total_points(user)
    user.points.with_deleted.by_date(*date_range).total_amount
  end

  def date_range
    current = Time.zone.now.beginning_of_year
    prev = current - CYCLES.years
    [prev, current]
  end
end