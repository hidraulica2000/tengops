class AddPublishedToNews < ActiveRecord::Migration
  def change
    add_column :news, :published, :boolean, :default => false
  end
end
