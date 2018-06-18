class Task < ApplicationRecord

  belongs_to :user

  validates :title, presence: true,
                    length: {minimum: 5}
  validates :user_id, presence:  true
  validates_numericality_of :priority, :greater_than => 0, less_than: 10
  validates :due_date, presence: true

  validate :expiration_date_cannot_be_in_the_past

  default_scope -> { order('due_date DESC')}

  private
  def expiration_date_cannot_be_in_the_past
    errors.add(:expiration_date, "can't be in the past") if
        !due_date.blank? and due_date.to_date < Date.today
  end
end
