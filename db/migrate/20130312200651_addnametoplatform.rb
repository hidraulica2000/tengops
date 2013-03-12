class Addnametoplatform < ActiveRecord::Migration
  def change
    add_column :platforms, :name, :string
  end
end
