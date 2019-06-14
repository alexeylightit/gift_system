# frozen_string_literal: true
class User < ApplicationRecord
  has_many :transactions
  has_many :points
  has_many :gifts

  enum loyalty: Loyalty.enum

  validates_presence_of :name, :birth_date

end

# == Schema Information
# Schema version: 20190611083722
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  birth_date :datetime
#  loyalty    :integer          default(0)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
