class TransactionForm < ApplicationForm
  DIVIDER = 10
  FACTOR = 2
  attr_accessor :user, :amount, :foreign

  validates :user, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :foreign, inclusion: { in: [true, false] }

  def submit!
    return false unless valid?
    add_transaction_points if transaction.save
    RewardService.new(user: user).run_scenario!(:fresh_user, :cache_back)
  end

  private

  def add_transaction_points
    PointsService.new(user: user).add_points(amount: transaction_points, reason: transaction)
  end

  def transaction_points
    points = amount / DIVIDER
    points *= FACTOR if foreign
    points
  end

  def transaction
    @transaction ||= Transaction.new(user: user, amount: amount, is_foreign: foreign)
  end

end