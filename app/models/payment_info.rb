class PaymentInfo < ActiveRecord::Base
  attr_accessible :title, :info, :market_id
  belongs_to :market
end
