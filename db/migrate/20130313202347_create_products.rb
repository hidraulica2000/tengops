class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.references :game
      t.references :market
      t.text :description
      t.decimal :price, :precision => 10, :scale => 2
      t.string :condition
      t.text :notes
      t.timestamps
    end
  end
end
