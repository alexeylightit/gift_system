# frozen_string_literal: true
class TransactionService < ApplicationService
  attr_reader :transaction
  DIVIDER = 10
  FACTOR = 2

  def initialize(user:, transaction:)
    @user = user
    @transaction = transaction
  end

  def save_transaction!
    return unless transaction.save
    PointsService.new(user: user).add_points(amount: transaction_points, reason: transaction)
    RewardService.new(user: user).run_scenario!(:fresh_user, :cache_back)
  end

  private

  def transaction_points
    points = transaction.amount / DIVIDER
    points *= FACTOR if transaction.is_foreign?
    points
  end

end