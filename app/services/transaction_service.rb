# frozen_string_literal: true
class TransactionService < ApplicationService
  DIVIDER = 10
  FACTOR = 2

  def initialize(user:, amount:)
    @user = user
    @amount = amount
  end

  def save_transaction!
    return unless amount.positive?
    # create_transaction
    PointsService.new(user: user).add_points(amount: calculate_bonus, reason: transaction)
    RewardService.new(user: user).run_scenario!(:fresh_user, :cache_back)
  end


  private

  def calculate_bonus
    points = amount / DIVIDER
    points *= FACTOR if transaction.is_foreign?
    points
  end

end