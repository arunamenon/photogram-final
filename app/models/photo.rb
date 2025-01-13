class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User", counter_cache: false

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # If you want comment_count/like_count to auto-update, add
  # belongs_to :owner, class_name: "User", counter_cache: :photos_count
  # or use `counter_culture` gem. For now, we’ll keep it simple.

  validates :owner_id, presence: true
end
