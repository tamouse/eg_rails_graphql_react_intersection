require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let!(:admin) { User.create!(handle: "admin", email: "admin@ex.com", password: "admin123456", password_confirmation: "admin123456", admin: true) }
  let!(:user1) { User.create!(handle: "Jane", email: "jane@ex.com", password: "p", password_confirmation: "p") }
  let!(:user2) { User.create!(handle: "Sally", email: "sally@ex.com", password: "p", password_confirmation: "p") }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it "allows the user to see their own record" do
      expect(subject).to permit(user1, user1)
    end
    it "does not let the user see another record" do
      expect(subject).not_to permit(user1, user2)
    end
    it "let's the admin see anyone's record" do
      expect(subject).to permit(admin, user1)
    end
  end

  permissions :create? do
    it "does not let a regular user create a user" do
      expect(subject).not_to permit(user1, User.new)
    end
    it "let's the admin create a new user" do
      expect(subject).to permit(admin, User.new)
    end
  end

  permissions :update? do
    it "allows admin to update any user" do
      expect(subject).to permit(admin, user1)
    end
    it "allows users to update their own user" do
      expect(subject).to permit(user1, user1)
    end
    it "does not allow user to update another user" do
      expect(subject).not_to permit(user1, user2)
    end

  end

  permissions :destroy? do
    it "only the admin can delete a user" do
      expect(subject).to permit(admin, user2)
    end
    it "non-admin users cannot delete their own user" do
      expect(subject).not_to permit(user1, user1)
    end
    it "non-admin users cannot delete another user" do
      expect(subject).not_to permit(user1, user1)
    end
  end
end
