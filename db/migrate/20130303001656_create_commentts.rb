class CreateCommentts < ActiveRecord::Migration
  def change
    create_table :commentts do |t|
      t.references :new
      t.references :user
      t.text :content
      t.timestamps
    end
  end
end
