class Task < ApplicationRecord

  belongs_to :user

  validates :title, presence: true,
                    length: {minimum: 5}
  validates :user_id, presence:  true

  default_scope -> { order('due_date DESC')}


end
