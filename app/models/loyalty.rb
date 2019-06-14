# frozen_string_literal: true
class Loyalty
  RULES = [
    { type: :default, condition: 0, key: 0 },
    { type: :gold, condition: 1000, key: 1 },
    { type: :platinum, condition: 5000, key: 2 }
  ]

  def self.enum
    RULES.map { |rule| [rule[:type], rule[:key]] }.to_h
  end

  def self.find_by_amount(amount)
    sorted_rules.reverse.find { |loyalty| loyalty[:condition] <= amount }
  end

  def self.find_by_type(type)
    RULES.find { |loyalty| loyalty.key(type.to_sym) }
  end

  private

  def self.sorted_rules
    Loyalty::RULES.sort_by { |loyalty| loyalty[:condition] }
  end


end