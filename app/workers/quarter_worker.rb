class QuarterWorker < ApplicationWorker

  def perform
    User.all.each do |user|
      RewardService.new(user: user).run_scenario! :quarter
    end
  end

end