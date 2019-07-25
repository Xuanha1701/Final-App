class Admin::AlbumsController < Admin::BasesController
    def index
      @albums = Album.all
    end
 end