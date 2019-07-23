class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  def show
    @user = User.find(params[:id])
    @photos = Photo.all
    @user_all = User.all
  end

  def myprofile
    @user = current_user
    @photos = Photo.all
    @user_all = User.all
  end

  def edit
  end

  def create

  end

  def update
    if current_user.update(update_basic_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :website,:bio, :email, :phone, :gender, :avatars, :role)
    end

    def update_basic_params
      params.require(:user).permit(:first_name,:avatars,:last_name,:email)
    end

end
