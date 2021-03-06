class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:profile]

  def index
    if user_signed_in?
      if current_user.admin
        @news = New.order("created_at DESC").limit(3).all
        return
      end
    end
    @news = New.published.order("created_at DESC").limit(3)
  end

  def profile
    @user = User.find_by_id(params[:id])
    unless @user
      redirect_to root_path
    end
    render :stream => true
  end

  def cover
    if @user == current_user
      @covers = Cover.all
    else
      redirect_to profile_path(current_user)
    end
  end

  def cover_selected
    current_user.cover = Cover.find(params[:id])
    if current_user.save
      redirect_to profile_path(current_user)
    end
  end

  def psn_info
    @id = params[:id]
    render partial: 'psn_info'
  end
end
