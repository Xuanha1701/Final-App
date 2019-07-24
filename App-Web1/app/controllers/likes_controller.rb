class LikesController < ApplicationController
  # before_action :find_post
  before_action :authenticate_user!
  # before_action :find_like, only: [:destroy]
    def create
      @user = current_user.id
      @photo = Photo.find(params_data_photo)
      likes = {user_id: @user, photo_id: @photo}
      @like = Like.new(likes)

      @like.save!
      if @like.save
        redirect_to user_path(@user)
      else
       redirect_to photo_path
      end
    end

    def find_like
      @like = @photo.likes.find(params[:id])
    end

    def index
      redirect_to root_path
    end

    def destroy
      if !(already_liked?)
        flash[:notice] = "Cannot unlike"
      else
        @like.destroy
      end
      redirect_to photo_path(@photo)
    end

  private

    # def find_post
    #   @photo = Photo.find(params[:id])
    #   byebug
    # end

    # def already_liked?
    # Like.where(user_id: current_user.id, photo_id: params[:id]).exists?
    # end
    # def params_data_photo
    #      params.require(:data).permit(:data)
    # end
end
