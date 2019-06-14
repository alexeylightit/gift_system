# frozen_string_literal: true
class PointsService < ApplicationService

  def add_points(amount:, reason:)
    points = Point.new(user: user, amount: amount, reason: reason)
    return points.errors.messages unless points.save
    RewardService.new(user: user).run_scenario!(:points)
    LoyaltyService.new(user: user).upgrade!
  end

end