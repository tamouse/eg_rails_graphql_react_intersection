class UserPolicy < ApplicationPolicy
  # NOTE: The thing to keep in mind here, is that both `user` and `record` are User
  # records. It gets confusing keeping track of which one is being talking about. The
  # `user` is the User record that is having it's permissions checked for access to the
  # `record` User record.  @tamouse 2020-04-25T04:53:39-0500

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

  def destroy?
    # NOTE: This one is a bit more complicated. I don't want to allow anyone but admins
    # to be able to destroy a user record, but I also don't want admins to be able to
    # destroy themselves, NOR do I want anyone to be able to destroy the super admin,
    # i.e., the first admin in the system. Oy, vey. @tamouse 2020-04-25T05:00:14-0500

    return false unless super
    return false if user == record
    return false if record.superadmin?

    true
  end
end
