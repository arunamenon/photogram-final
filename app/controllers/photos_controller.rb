class PhotosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # Show a list of photos. Public photos visible to everyone
    # You could filter only public user's photos if needed
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner_id = current_user.id

    if @photo.save
      redirect_to @photo, notice: "Photo created successfully."
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    # Add authorization checks if needed
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to @photo, notice: "Photo updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_url, notice: "Photo deleted successfully."
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
