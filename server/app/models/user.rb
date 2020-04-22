class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /.+@.+\.[a-z0-9]+\z/i
  validates_presence_of :password_digest

  has_many :posts, foreign_key: 'author_id', inverse_of: 'author'

  def admin!
    self.admin = true
    save!
  end
end
