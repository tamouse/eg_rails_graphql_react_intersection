class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :author

  scope :published, -> { where(published: true) }
  scope :drafts, -> { where(published: false) }

  def publish!
    self.published = true
    save!
  end
end
