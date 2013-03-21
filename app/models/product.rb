class Product < ActiveRecord::Base
  attr_accessible :title, :game_id, :market_id, :description, :price, :condition, :notes, :published, :units
  belongs_to :market
  belongs_to :game
  validates :units, :numericality => { :only_integer => true,
                                        :less_than_or_equal_to => 99,
                                        :greater_than_or_equal_to => 1 }
  validates :price, :numericality => { :less_than_or_equal_to => 1000000,
                                       :greater_than_or_equal_to => 50 }

end
