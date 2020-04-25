## The User model
class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /.+@.+\.[a-z0-9]+\z/i
  validates_presence_of :password_digest

  has_many :posts, foreign_key: 'author_id', inverse_of: 'author'

  scope :admins, -> { where(admin: true) }

  def admin!
    self.admin = true
    save!
  end

  def self.superadmin
    admins.order(created_at: :asc).first
  end

  def superadmin?
    id == self.class.admins.order(created_at: :asc).first&.id
  end
end
