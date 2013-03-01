class CreateAttachements < ActiveRecord::Migration
  def change
    create_table :attachements do |t|
      t.references :new
      t.string :url
      t.timestamps
    end
  end
end
