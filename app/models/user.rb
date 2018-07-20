class User < ApplicationRecord

  # Name Validations
  validates :name, presence: true
  validates :name, length: { maximum: 50,
                             minimum: 3 }
  VALID_NAME_REGEX = /\A[a-z]+\z/i
  validates :name, format: { with: VALID_NAME_REGEX }

  # Email Validations
  validates :email, presence: true
  validates :email, length: { maximum: 200,
                              minimum: 8 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
