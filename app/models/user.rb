class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :tasks

  validates :first_name,  presence: true,
                          length: {maximum: 50}
  validates :last_name, presence: true,
                        length: {maximum: 50}
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: {minimum: 6}

  #return the full name of user
  def full_name
    "#{first_name} #{last_name}"
  end

  before_save {self.email = email.downcase}
end
