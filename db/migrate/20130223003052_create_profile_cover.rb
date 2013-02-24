class CreateProfileCover < ActiveRecord::Migration
  def change
    remove_column :users, :photo
    add_column :users, :cover_id, :integer
  end
end
