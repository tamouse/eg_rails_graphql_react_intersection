class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    index?
  end

  def create?
    super || user.persisted?
  end

  def update?
    super ||
      (record.persisted? &&
       user.persisted? &&
       user.id == record.author_id)
  end

  def destroy?
    update?
  end
end
