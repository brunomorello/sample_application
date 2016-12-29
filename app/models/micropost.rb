class Micropost < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Use Staby Lambda
  default_scope -> { order(created_at: :desc) }

  # Validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
