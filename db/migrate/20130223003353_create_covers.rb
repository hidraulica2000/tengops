class CreateCovers < ActiveRecord::Migration
  def change
    create_table :covers do |t|
      t.string :title
      t.string :url_big
      t.string :url_thumb
      t.timestamps
    end
  end
end
