class HomeController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  def index
    @user = current_user
    @photos = Photo.public_photos.page(params[:page])
    @albums = Album.includes(:photos).page(params[:page])
    @photo = Photo.new
    @album = Album.new
  end
end
