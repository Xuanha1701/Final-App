class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user  = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to current_user
  end
  # def follow(user_id)

  #   following_relationships.create(following_id: user_id)
  # end

  # def unfollow(user_id)
  #   following_relationships.find_by(following_id: user_id).destroy
  # end
  private

  def user_params
    params.require(:user).permit(:username, :name, :website,:bio, :email, :phone, :gender, :avatar)
  end
end
