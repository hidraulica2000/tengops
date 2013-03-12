class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.text :overview
      t.string :developer
      t.string :manufacturer
      t.string :cpu
      t.string :memory
      t.string :graphics
      t.string :display
      t.string :media
      t.integer :max_controllers
      t.string :photo
      t.timestamps
    end
  end
end
