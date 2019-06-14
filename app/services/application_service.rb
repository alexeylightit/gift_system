# frozen_string_literal: true
class ApplicationService
  attr_reader :user

  def initialize(user:)
    @user = user
  end

end