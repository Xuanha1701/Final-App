module HomeHelper
  def show_photos_albums_user
        unless current_user.albums.empty?
          unless current_user.albums[@album.id].photos.empty?

          end
        end


  end
end
