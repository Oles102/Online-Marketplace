class ReviewPolicy < ApplicationPolicy
  def create?
    user.has_role?(:user)
  end

  def update?
    user.has_role?(:user) && record.user_id == user.id
  end

  def destroy?
    user.has_role?(:admin)
  end

end

