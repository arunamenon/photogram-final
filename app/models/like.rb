class Like < ApplicationRecord
  belongs_to :fan, class_name: "User"
  belongs_to :photo, counter_cache: true  # increments Photo.likes_count

  validates :fan_id, presence: true
  validates :photo_id, presence: true
end
