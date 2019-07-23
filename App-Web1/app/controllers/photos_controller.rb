class PhotosController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @photo = Photo.order('created_at DESC')
    @user = User.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params_image)
    @photo.photoable = current_user
    @photo.save
    redirect_to root_path
  end

  def show
    @photo_all = current_user.photos.all.order(:created_at)
  end

  def edit
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    redirect_to user_path(current_user)
  end

  private

  def params_image
    params.require(:photo).permit(:image, :title, :description, :public)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
