class User < ApplicationRecord
  VALID_NAME_REGEX = /\A[a-z]+\z/i
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
end
