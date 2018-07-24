class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_secure_password

  VALID_NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates :name, presence: true,
                   length: { maximum: 50,
                             minimum: 3 },
                   format: { with: VALID_NAME_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 200,
                              minimum: 8 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true,
                       length: { minimum: 6 },
                       allow_nil: true

 def User.digest(string)
   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
 end
end
