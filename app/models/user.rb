class User < ApplicationRecord
  has_secure_password
  has_many :goals, dependent: :destroy

  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }, format: { without: /\s/, message: "must not contain spaces" }
  validates :email, presence: true, uniqueness:true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end
