class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # Show a list of users
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # This can show user details, including photos if allowed
  end
end
