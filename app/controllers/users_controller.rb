class UsersController < ApplicationController
  # Let everyone see the index and show pages:
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.order(:username)
    # index.html.erb will list usernames, private? column, follow/unfollow if signed in
  end

  def show
    @user = User.find_by(username: params[:username])
    # If user not found, handle accordingly
    # If user.private? and we’re not allowed to see, handle accordingly
  end

  def feed
    @user = User.find_by(username: params[:username])
    # Collect photos posted by the people @user is following
    # For simplicity, suppose status=accepted means they’re actually followed
    leader_ids = FollowRequest.where(sender_id: @user.id, status: "accepted").pluck(:recipient_id)
    @feed_photos = Photo.where(owner_id: leader_ids).order(created_at: :desc)
  end

  def liked_photos
    @user = User.find_by(username: params[:username])
    # Collect photos that the user has liked
    photo_ids = Like.where(fan_id: @user.id).pluck(:photo_id)
    @liked_photos = Photo.where(id: photo_ids).order(created_at: :desc)
  end

  def discover
    @user = User.find_by(username: params[:username])
    # "Discover" = photos liked by the people @user is following
    leader_ids = FollowRequest.where(sender_id: @user.id, status: "accepted").pluck(:recipient_id)
    # All likes from those leaders:
    photo_ids = Like.where(fan_id: leader_ids).pluck(:photo_id)
    @discover_photos = Photo.where(id: photo_ids).order(created_at: :desc)
  end

  # More actions as needed (e.g., update, destroy) if you want /users/edit
end
