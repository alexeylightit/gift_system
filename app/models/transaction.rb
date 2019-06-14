# frozen_string_literal: true
class Transaction < ApplicationRecord
  belongs_to :user
  has_one :point, as: :reason
  monetize :amount_cents, as: :amount

  scope :greater_than, ->(amount) { where(amount_cents: (amount.to_money.cents)..Float::INFINITY) }
  scope :by_date, ->(start_date, end_date) { where(created_at: start_date..end_date) }
  scope :total_amount, -> { sum(:amount_cents).to_money.amount }

  validates_presence_of :user

end

# == Schema Information
# Schema version: 20190611083722
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  is_foreign      :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint
#
# Indexes
#
#  index_transactions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
