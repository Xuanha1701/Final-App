class ChangePostIdToPhotoId < ActiveRecord::Migration[5.2]
  def up
    rename_column :likes, :post_id, :photo_id
  end

  def down
    rename_column :likes, :photo_id, :post_id
  end
end
