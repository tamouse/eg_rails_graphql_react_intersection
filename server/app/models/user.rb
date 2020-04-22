class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /.+@.+\.[a-z0-9]+\z/i
  validates_presence_of :password_digest

  def admin!
    self.admin = true
    save!
  end
end
