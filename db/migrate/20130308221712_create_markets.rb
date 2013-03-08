class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.references :user
      t.string :title
      t.string :description
      t.string :city
      t.string :country
      t.string :cover
      t.string :profile_picture
      t.timestamps
    end
  end
end
