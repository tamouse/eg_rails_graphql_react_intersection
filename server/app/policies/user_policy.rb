class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    super || user == record
  end

  def update?
    super || (record.persisted? && user == record)
  end

end
