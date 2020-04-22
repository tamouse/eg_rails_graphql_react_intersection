class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def new?
    create?
  end

  def create?
    !record.persisted? && user.admin?
  end

  def edit?
    update?
  end

  def update?
    record.persisted? && user.admin?
  end

  def destroy?
    record.persisted? && user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
