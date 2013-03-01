class NewsController < ApplicationController

  def index
    if user_signed_in?
      if current_user.admin
        @news = New.order("created_at DESC").all
        return
      end
    end
    @news = New.published.order("created_at DESC")
  end

  def show
    @new = New.find(params[:id])
  end

end
