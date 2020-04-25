require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  let!(:admin) {Fabricate(:user, admin: true)}
  let!(:user4posts) do
    u = Fabricate(:user)
    u.posts = Fabricate.times(4, :post, author: u)
    u
  end

  let!(:user3posts) do
    u = Fabricate(:user)
    u.posts = Fabricate.times(3, :post, author: u)
    u
  end

  let!(:user1post) do
    u = Fabricate(:user)
    u.posts = Fabricate.times(1, :post, author: u)
    u
  end

  let!(:user0posts) do
    Fabricate(:user)
  end

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :index? do
    it "permits all posts" do
      expect(subject).to permit(User)
    end
  end

  permissions :show? do
    it "permits anyone to see posts" do
      expect(subject).to permit(user4posts, user1post.posts.first)
    end
  end

  permissions :create? do
    it "permits any user to create posts" do
      expect(subject).to permit(user1post, Post.new)
    end
    it "does not permit anon users to create posts" do
      expect(subject).not_to permit(User.new, Post.new)
    end
  end

  permissions :update? do
    it "permits updating own posts" do
      expect(subject).to permit(user1post, user1post.posts.first)
    end
    it "does not permit anyone to update another user's posts" do
      expect(subject).not_to permit(user3posts, user1post.posts.first)
    end
    it "does not permit nil user to update another user's posts" do
      expect(subject).not_to permit(User.new, user1post.posts.first)
    end
    it "permits admin to update post" do
      expect(subject).to permit(admin, user1post.posts.first)
    end
  end

  permissions :destroy? do
    it "permits destroying own posts" do
      expect(subject).to permit(user1post, user1post.posts.first)
    end
    it "does not permit anyone to destroy another user's posts" do
      expect(subject).not_to permit(user3posts, user1post.posts.first)
    end
    it "does not permit nil user to destroy another user's posts" do
      expect(subject).not_to permit(User.new, user1post.posts.first)
    end
    it "permits admin to destroy post" do
      expect(subject).to permit(admin, user1post.posts.first)
    end
  end
end
