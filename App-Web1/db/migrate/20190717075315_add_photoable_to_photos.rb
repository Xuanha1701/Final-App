class AddPhotoableToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :photoable_id, :integer
    add_column :photos, :photoable_type, :string

  end
end
