class User < ApplicationRecord
  before_save { self.email = email.downcase } # save 之前把 email 轉成小寫

  validates :name, presence: true, length: { maximum: 60 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true } # rails 6.1 之後不會 enforce case_sensitive

  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  def self.digest(string)
    # for fixture file
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
