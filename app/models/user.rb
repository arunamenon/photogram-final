class User < ApplicationRecord
  # For Devise-based auth:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # A user can have many photos (the user is the "owner"):
  has_many :photos, foreign_key: "owner_id", dependent: :destroy

  # A user can have many comments (the user is the "author"):
  has_many :comments, foreign_key: "author_id", dependent: :destroy

  # A user can have many likes (the user is the "fan"):
  has_many :likes, foreign_key: "fan_id", dependent: :destroy

  # FollowRequests
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy

  # For the “feed” and “discover” features, you can define more associations here:
  has_many :leaders, through: :sent_follow_requests, source: :recipient
  has_many :followers, through: :received_follow_requests, source: :sender

  # If status == "accepted", then we can define followings, etc. (not shown in detail)

  # Validations for the columns:
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
