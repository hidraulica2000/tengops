class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.references :market
      t.string :twitter
      t.string :facebook
      t.string :phone
      t.string :cellphone
      t.string :google_plus
      t.timestamps
    end
  end
end
