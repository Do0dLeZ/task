class User < ApplicationRecord
  has_many :tasks
  #return the full name of user
  def full_name
    "#{first_name} #{last_name}"
  end
end
