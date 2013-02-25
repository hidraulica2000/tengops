class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:profile]

  def profile
    @user = User.find_by_id(params[:id])
    unless @user
      redirect_to root_path
    end
    render :stream => true
  end

  def cover
    @covers = Cover.all
  end

  def cover_selected
    @user = current_user
    @user.cover = Cover.find(params[:id])
    if @user.save
      redirect_to profile_path(current_user)
    end
  end

  def psn_info
    @id = params[:id]
    render partial: 'psn_info'
  end
end
