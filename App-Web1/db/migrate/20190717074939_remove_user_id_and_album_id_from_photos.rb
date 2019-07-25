class RemoveUserIdAndAlbumIdFromPhotos < ActiveRecord::Migration[5.2]
  def change
    remove_column :photos, :user_id, :integer
    remove_column :photos, :album_id, :integer
  end
end
