class AddTypeToAssociatedPictures < ActiveRecord::Migration
  def change
    add_column :associated_pictures, :type, :string
  end
end
