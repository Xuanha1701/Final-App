class AlbumsController < ApplicationController
before_action :authenticate_user!, only: [:edit, :update, :destroy]
  def index
    @photo = Photo.all
  end

  def show
    @current_album = Album.includes(:photos).find(params[:id])
    @album_photos = @current_album.photos
  end

  def new
    @album = album.new
    @album_photo = @album.photos.build
  end

  def edit
    @album_photo = @album.photos.build
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      params[:photos]['image'].each do |a|
        @album_photo = @album.photos.create!(:image => a)
      end
      flash[:notice]= 'album was successfully created.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        params[:photos]['image'].each do |a|
          @album_photo = @album.photos.create!(:image => a)
        end
        format.html { redirect_to @album, notice: 'album was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
     format.html { redirect_to Albums_urAlbumotice: 'album was successfully destroyed.' }
    end
  end

  def show_photos
    @user = current_user
    @photos_on_album = @user.albums_photos.map{|x| x.image.url}
    byebug
  end
  helper_method :show_photos
  private


  def album_params
      params.require(:album).permit(:title,:description,:user_id,{photos:[]})
  end
end
