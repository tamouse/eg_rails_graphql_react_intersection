require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validates post' do
    subject { Post.new }
    it "must have a title" do
      aggregate_failures do
        expect(subject.validate).to be_falsy
        expect(subject.errors.full_messages).to include("Title can't be blank")
      end
    end
    it "must have content" do
      aggregate_failures do
        expect(subject.validate).to be_falsy
        expect(subject.errors.full_messages).to include("Content can't be blank")
      end
    end
    it "must have an author" do
      aggregate_failures do
        expect(subject.validate).to be_falsy
        expect(subject.errors.full_messages).to include("Author can't be blank")
      end
    end
  end

  describe '#publish!' do
    let!(:post) {Fabricate(:post)}
    it "sets the published flag to true" do
      aggregate_failures do
        expect(post.published).to be_falsy
        post.publish!
        post.reload
        expect(post.published).to be_truthy
      end
    end
  end
end
