class LocationPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def new?
    true
  end
end
