class SubtodoPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    is_onwer?
  end

  def update?
    is_onwer?
  end

  def destroy?
    is_onwer? || is_admin?
  end

  private
  def is_onwer?
    record.user == user
  end

  def is_admin?
    user.is_admin == true
  end
end
