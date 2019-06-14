# frozen_string_literal: true
class TransactionForm < ApplicationForm
  attr_accessor :user, :amount, :foreign

  validates :user, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :foreign, inclusion: { in: [true, false] }

  def submit!
    return false unless valid?
    TransactionService.new(user: user, transaction: transaction).save_transaction!
  end

  private

  def transaction
    @transaction ||= Transaction.new(user: user, amount: amount, is_foreign: foreign)
  end

end