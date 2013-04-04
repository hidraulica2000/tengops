class Market < ActiveRecord::Base
  attr_accessible :user_id, :title, :description, :city_id, :country_id, :cover, :profile_picture
  belongs_to :user
  has_one :country
  has_one :city
  has_many :products
  has_one :contact_info
  has_one :payment_info

  def get_name(token, id)
    uri = "https://graph.facebook.com/#{id}?name&access_token=#{token}"
    json = RestClient.get uri
    link = JSON.parse(json)["name"]
  end

  def group_link id
    uri = "https://www.facebook.com/#{id}"
  end

end
