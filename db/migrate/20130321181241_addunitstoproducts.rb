class Addunitstoproducts < ActiveRecord::Migration
  def change
    add_column :products, :units, :integer
    add_index :games, :game_title
  end
end
