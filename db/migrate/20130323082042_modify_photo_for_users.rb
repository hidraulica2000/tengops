class ModifyPhotoForUsers < ActiveRecord::Migration
  def change
    remove_column :users, :photo
    add_column :users, :photo, :text
  end
end
