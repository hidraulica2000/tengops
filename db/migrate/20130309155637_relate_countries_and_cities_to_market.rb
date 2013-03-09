class RelateCountriesAndCitiesToMarket < ActiveRecord::Migration
  def change
    remove_column :markets, :city
    remove_column :markets, :country
    add_column :markets, :city_id, :integer
    add_column :markets, :country_id, :integer
  end
end
