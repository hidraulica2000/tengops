module MarketsHelper
  def current_market
    current_user.market
  end
end
