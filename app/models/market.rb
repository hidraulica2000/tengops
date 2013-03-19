class Market < ActiveRecord::Base
  attr_accessible :user_id, :title, :description, :city_id, :country_id, :cover, :profile_picture
  belongs_to :user
  has_one :country
  has_one :city
  has_many :products
end
