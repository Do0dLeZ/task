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

  before_save :downcase_email
  before_create :create_remember_token, :confirmation_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    self.update_attribute(:email_confirmed, true)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def downcase_email
      self.email = email.downcase
    end

    def confirmation_token
      if self.confirm_token.blank?
        self.confirm_token= SecureRandom.urlsafe_base64.to_s
      end
    end
end
