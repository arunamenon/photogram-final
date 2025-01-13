class PhotosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if user_signed_in?
      # Show all photos that belong to non-private owners OR me
      public_user_ids = User.where(private: false).pluck(:id)
      allowed_user_ids = public_user_ids << current_user.id
      @photos = Photo.where(owner_id: allowed_user_ids)
    else
      # Signed out => show only photos from non-private owners
      public_user_ids = User.where(private: false).pluck(:id)
      @photos = Photo.where(owner_id: public_user_ids)
    end
  end

  def show
    @photo = Photo.find(params[:id])
    # If the photo belongs to a private user and we’re not allowed to see it => redirect or error
    if @photo.owner.private? && @photo.owner != current_user
      # Optionally check if we follow them
      # For now, just redirect to sign_in or show an alert
      redirect_to root_path, alert: "You're not allowed to see that."
    end
  end

  def create
    if user_signed_in?
      new_photo = Photo.new
      new_photo.owner_id = current_user.id
      new_photo.caption  = params[:caption]
      new_photo.image    = params[:image]
      # likes_count, comments_count updated automatically

      if new_photo.save
        redirect_to root_path, notice: "Photo added successfully"
      else
        redirect_to root_path, alert: new_photo.errors.full_messages.to_sentence
      end
    else
      redirect_to new_user_session_path, alert: "You must sign in to add photos."
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.owner == current_user
      @photo.destroy
      redirect_to root_path, notice: "Photo deleted."
    else
      redirect_to root_path, alert: "Not allowed."
    end
  end

  # etc.
end
