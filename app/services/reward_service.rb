# frozen_string_literal: true
class RewardService < ApplicationService

  def run_scenario!(*scenarios)
    scenarios.reject { |scenario| scenario.in? self.class.scenarios }
    scenarios.each do |scenario|
      settings = self.class.settings[scenario]
      reward_class = settings[:reward]
      condition_class = settings[:condition]
      reward = reward_class.new(user: user, type: scenario, amount: settings[:amount])
      condition_class.new(user: user, reward: reward).issue_reward!
    end
  end

  def self.scenarios
    settings.keys
  end

  private

  def self.settings
    {
      birthday: {
        condition: RewardCondition::Birthday,
        reward: Reward::Coffee,
        amount: 1
      },
      cache_back: {
        condition: RewardCondition::CacheBack,
        reward: Reward::CacheBack,
        amount: 0.05
      },
      fresh_user: {
        condition: RewardCondition::FreshUser,
        reward: Reward::MovieTicket,
        amount: 1
      },
      loyalty: {
        condition: RewardCondition::GoldUser,
        reward: Reward::AirportAccess,
        amount: 4
      },
      points: {
        condition: RewardCondition::MonthlyPoints,
        reward: Reward::Coffee,
        amount: 1
      },
      quarter: {
        condition: RewardCondition::Quarter,
        reward: Reward::Points,
        amount: 100
      }
    }
  end


end