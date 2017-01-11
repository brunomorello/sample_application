class Micropost < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Use Staby Lambda
  default_scope -> { order(created_at: :desc) }

  # Uploader
  mount_uploader :picture, PictureUploader

  # Validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private

    # Validates the size of an uploaded picture
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end
    end
end
