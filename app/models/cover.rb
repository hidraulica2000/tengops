class Cover < ActiveRecord::Base
  attr_accessible :title, :url_big, :url_thumb
  has_many :users
  
end
