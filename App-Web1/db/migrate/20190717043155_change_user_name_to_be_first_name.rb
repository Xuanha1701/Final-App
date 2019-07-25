class ChangeUserNameToBeFirstName < ActiveRecord::Migration[5.2]
  def up
    rename_column :users, :username, :first_name
    rename_column :users, :name, :last_name
  end

  def down
    rename_column :users, :first_name, :username
    rename_column :users, :last_name, :name
  end
end
