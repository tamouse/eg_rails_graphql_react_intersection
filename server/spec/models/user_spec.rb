require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'email validations' do
    it "email cannot be empty" do
      subject.validate
      aggregate_failures do
        expect(subject.errors.full_messages).to include("Email is invalid")
        expect(subject.errors.full_messages).to include("Email can't be blank")
      end
    end
    it "email must include a domain" do
      subject.email = "bill"
      subject.validate
      aggregate_failures do
        expect(subject.errors.full_messages).to include("Email is invalid")
        expect(subject.errors.full_messages).not_to include("Email can't be blank")
      end
    end
    it "email can't be just an @" do
      subject.email = "@"
      subject.validate
      aggregate_failures do
        expect(subject.errors.full_messages).to include("Email is invalid")
        expect(subject.errors.full_messages).not_to include("Email can't be blank")
      end
    end
    it "email can't start with @" do
      subject.email = "@ex.com"
      subject.validate
      aggregate_failures do
        expect(subject.errors.full_messages).to include("Email is invalid")
        expect(subject.errors.full_messages).not_to include("Email can't be blank")
      end
    end
    it "email must have a domain name _and_ a tld" do
      subject.email = "bill@com"
      subject.validate
      aggregate_failures do
        expect(subject.errors.full_messages).to include("Email is invalid")
        expect(subject.errors.full_messages).not_to include("Email can't be blank")
      end
    end
    it "email is a valid email" do
      subject.email = "bill@ex.com"
      subject.validate
      aggregate_failures do
        expect(subject.errors.full_messages).not_to include("Email is invalid")
        expect(subject.errors.full_messages).not_to include("Email can't be blank")
      end
    end
    describe "ensures unique email" do
      let(:user1) { User.create!(email: "jill@ex.com", password: "password", password_confirmation: "password")}
      let(:user2) { User.new(email: "jill@ex.com", password: "password", password_confirmation: "password")}
      it "cannot save the repeat email" do
        expect(user1).to be_persisted
        expect(user2.validate).to be_falsy
        expect(user2.errors.full_messages).to include("Email has already been taken")
      end
    end
    describe "ensures there is a password digest" do
      subject { User.new(email: "jane@ex.com", password: "password", password_confirmation: "password")}
      it "password digest included" do
        expect(subject.validate).to be_truthy
        expect(subject.errors.full_messages).not_to include("Password digest can't be blank")
      end
    end
  end

  describe "admin field" do
    subject { User.create(email: "sue@ex.com", password: "p", password_confirmation: "p") }
    it "new users are not admin by default" do
      expect(subject.admin?).not_to be_truthy
    end
  end
end
