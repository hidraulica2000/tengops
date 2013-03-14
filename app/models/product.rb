class Product < ActiveRecord::Base
 attr_accessible :title, :game_id, :market_id, :description, :price, :condition, :notes
 belongs_to :market
 belongs_to :game


end