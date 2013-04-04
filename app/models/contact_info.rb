class ContactInfo < ActiveRecord::Base
  attr_accessible :market_id, :twitter, :facebook, :google_plus, :phone, :cellphone, :whatsapp
  belongs_to :market
end
