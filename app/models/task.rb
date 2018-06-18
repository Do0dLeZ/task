class Task < ApplicationRecord
  validates :title, presence: true,
                    length: {minimum: 5}

  # belongs_to :user

  # before_create :set_current_user
  #
  # private
  #
  #   def set_current_user
  #     self.user= current_user
  #   end
end
