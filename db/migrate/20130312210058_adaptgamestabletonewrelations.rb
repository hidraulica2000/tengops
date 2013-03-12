class Adaptgamestabletonewrelations < ActiveRecord::Migration
  def change
    remove_column :games, :platform
    remove_column :games, :esrb
    remove_column :games, :genres
    remove_column :games, :publisher
    remove_column :games, :developer
    add_column :games, :platform_id, :integer
    add_column :games, :esrb_id, :integer
    add_column :games, :genre_id, :integer
    add_column :games, :publisher_id, :integer
    add_column :games, :developer_id, :integer
  end
end
