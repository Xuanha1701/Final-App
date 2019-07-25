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

  def get_photo
    @photo = Photo.find params[:photo_id]
    respond_to do |format|
      format.js
    end
  end

  def likes
    puts params
    if Like.where(photo_id: params[:photo_id], user_id: current_user.id).empty?
      @like = Like.new(photo_id: params[:photo_id], user_id: current_user.id)
      if @like.save
        redirect_to root_path
      else
        flash[:notice] = 'Can\'t like this photo'
      end
    else
      puts 'already liked'
    end
  end
  def unlike
    puts params
    unless Like.where(photo_id: params[:photo_id], user_id: current_user.id).empty?
      @like = Like.where(photo_id: params[:photo_id], user_id: current_user.id).take
      @like.destroy
    end
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
