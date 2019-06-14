class Reward
  attr_reader :user

  def initialize(user)
    @user = user
  end

  # Virtual method
  def can_be_gifted?
    false
  end

  def was_gifted?
    gifted_reward.exists?
  end

  def gifted_by_dates(start_date, end_date)
    return false unless gifted_reward
    gifted_reward.created_at.between? start_date, end_date
  end

  private

  def gifted_reward
    @gifted_reward ||= user.gifts.where(type: type)
  end
end