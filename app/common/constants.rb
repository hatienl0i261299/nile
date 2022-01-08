# frozen_string_literal: true

# Define text for GroupRole
class GroupRole
  attr_reader :admin, :user, :viewer

  def initialize
    @admin = 'admin'
    @user = 'user'
    @viewer = 'viewer'
  end
end

# Define text for ReasonError
class ReasonError
  attr_reader :validateError

  def initialize
    @validateError = 'Validation failed: '
  end
end
