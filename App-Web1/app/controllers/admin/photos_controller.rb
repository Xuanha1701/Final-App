class Admin::PhotosController < Admin::BasesController
    def index
      @photos = Photo.all
    end
 end