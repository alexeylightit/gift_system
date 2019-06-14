# frozen_string_literal: true
class Point < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :reason, polymorphic: true

  scope :by_date, ->(start_date, end_date) { where(created_at: start_date..end_date) }
  scope :group_year, ->(date_range) { by_year(:created_at, range: date_range) }
  scope :total_amount, -> { sum(:amount) }

  def self.max_year_amount(start_date = Time.zone.now.beginning_of_year, end_date = Time.zone.now.end_of_year)
    group_by_year(:created_at, range: start_date..end_date).total_amount.values.max
  end

end

# == Schema Information
# Schema version: 20190611083722
#
# Table name: points
#
#  id          :bigint           not null, primary key
#  amount      :float
#  deleted_at  :datetime
#  reason_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  reason_id   :integer
#  user_id     :bigint
#
# Indexes
#
#  index_points_on_deleted_at                 (deleted_at)
#  index_points_on_reason_type_and_reason_id  (reason_type,reason_id)
#  index_points_on_user_id                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
