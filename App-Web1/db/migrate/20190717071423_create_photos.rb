class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.integer :album_id

      t.timestamps
    end
    add_index :photos,[:user_id,:album_id]
  end
end
