class CreateAssociatedPictures < ActiveRecord::Migration
  def change
    create_table :associated_pictures do |t|
      t.integer :subject_id
      t.text :url
      t.timestamps
    end
  end
end
