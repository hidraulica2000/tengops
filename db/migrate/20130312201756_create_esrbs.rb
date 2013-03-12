class CreateEsrbs < ActiveRecord::Migration
  def change
    create_table :esrbs do |t|
      t.string :name
      t.timestamps
    end
  end
end
