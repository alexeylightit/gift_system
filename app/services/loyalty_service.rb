# frozen_string_literal: true
class LoyaltyService < ApplicationService
  delegate :points, to: :user

  def upgrade!
    return unless next_rank?
    next_type = next_loyalty[:type]
    RewardService.new(user: user).run_scenario!(:loyalty) if update_loyalty(next_type)
  end

  def set_by_points(points = 0)
    loyalty = points_loyalty points
    update_loyalty loyalty[:type]
  end

  private

  def update_loyalty(loyalty_type)
    user.update(loyalty: loyalty_type)
  end

  def next_rank?
    return if downgrade?
    user.loyalty != next_loyalty[:type]
  end

  def downgrade?
    next_loyalty[:condition] <= current_loyalty[:condition]
  end

  def next_loyalty
    @next_loyalty ||= points_loyalty total_points
  end

  def current_loyalty
    @current_loyalty ||= Loyalty.find_by_type user.loyalty
  end

  def total_points
    @total_points ||= points.total_amount
  end

  def points_loyalty(points)
    Loyalty.find_by_amount points
  end
end