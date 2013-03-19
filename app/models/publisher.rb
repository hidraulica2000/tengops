class Publisher < ActiveRecord::Base
  attr_accessible :name
  has_many :games
  default_scope order('name ASC')
end
