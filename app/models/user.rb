class User < ApplicationRecord
  include UserAuth::Tokenizable
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }, on: :create
  has_secure_password

  def self.find_activated(email)
    find_by(email: email, activated: true)
  end

  def email_activate?
    users = User.where.not(id: id)
    users.find_activated(email).present?
  end

  def my_json
    as_json(only: [:id, :name, :email, :created_at])
  end
end
