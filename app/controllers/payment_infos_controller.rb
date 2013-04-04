class PaymentInfosController < ApplicationController
  def new
    @market = current_user.market
    @payment_info = PaymentInfo.new
  end
end
