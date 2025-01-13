class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  # status might be "pending", "accepted", or "rejected"
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
end
