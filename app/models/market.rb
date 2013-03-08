class Market < ActiveRecord::Base
  attr_accessible :user_id, :title :description, :city, :country, :cover, :profile_picture
  belongs_to :user
end
