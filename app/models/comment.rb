class Comment < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :photo, counter_cache: true  # increments Photo.comments_count

  validates :body, presence: true
  validates :photo_id, presence: true
end
