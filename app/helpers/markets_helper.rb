module MarketsHelper
  def current_market
    Market.find(params[:market_id])
  end
end
