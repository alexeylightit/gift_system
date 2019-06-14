# frozen_string_literal: true
class Gift < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :user
  has_one :point, as: :reason
end

# == Schema Information
# Schema version: 20190611083722
#
# Table name: gifts
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  reward     :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_gifts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
